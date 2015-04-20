require_relative '../../../puppet_x/puppetlabs/aws.rb'
require 'retries'

Puppet::Type.type(:ec2_vpc_customer_gateway).provide(:v2, :parent => PuppetX::Puppetlabs::Aws) do
  confine feature: :aws

  mk_resource_methods
  remove_method :tags=

  def self.instances()
    regions.collect do |region|
      gateways = []
      ec2_client(region).describe_customer_gateways.each do |response|
        response.data.customer_gateways.each do |gateway|
          hash = gateway_to_hash(region, gateway)
          gateways << new(hash) unless (gateway.state == "deleting" or gateway.state == "deleted")
        end
      end
      gateways
    end.flatten
  end

  read_only(:ip_address, :bgp_asn, :region, :type)

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]  # rubocop:disable Lint/AssignmentInCondition
        resource.provider = prov
      end
    end
  end

  def self.gateway_to_hash(region, gateway)
    {
      :name       => name_from_tag(gateway),
      :id         => gateway.customer_gateway_id,
      :bgp_asn    => gateway.bgp_asn,
      :state      => gateway.state,
      :type       => gateway.type,
      :region     => region,
      :ip_address => gateway.ip_address,
      :ensure     => :present,
      :tags       => tags_for(gateway),
    }
  end

  def exists?
    dest_region = resource[:region] if resource
    Puppet.info("Checking if Customer gateway #{name} exists in #{dest_region || region}")
    @property_hash[:ensure] == :present
  end

  def create
    Puppet.info("Creating Customer gateway #{name} in #{resource[:region]}")
    ec2 = ec2_client(resource[:region])

    response = ec2.create_customer_gateway(
      type: resource[:type],
      public_ip: resource[:ip_address],
      bgp_asn: resource[:bgp_asn],
    )

    with_retries(:max_tries => 5) do
      ec2.create_tags(
        resources: [response.data.customer_gateway.customer_gateway_id],
        tags: tags_for_resource
      )
    end

    @property_hash[:ensure] = :present
  end

  def destroy
    region = @property_hash[:region]
    Puppet.info("Destroying Customer gateway #{name} in #{region}")
    ec2_client(region).delete_customer_gateway(
      customer_gateway_id: @property_hash[:id]
    )
    @property_hash[:ensure] = :absent
  end
end

