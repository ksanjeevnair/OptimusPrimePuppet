include wget
class site::application {
wget::fetch { "downloading the latest application war file":
  source      => 'http://ec2-54-200-13-203.us-west-2.compute.amazonaws.com:8081/nexus/content/repositories/optimus/com/mycompany/myproject/1.1.66/myproject-1.1.66.war',
  destination => '/tmp/myproject-1.1.66.war',
  timeout     => 0,
  verbose     => false,
}
}
