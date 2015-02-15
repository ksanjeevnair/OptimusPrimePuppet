include wget
class site::application {
wget::fetch { "downloading the latest application war file":
  source      => 'http://ec2-54-200-13-203.us-west-2.compute.amazonaws.com:8081/nexus/content/repositories/optimus/com/mycompany/myproject/1.1.67/myproject-1.1.67.war',
  destination => '/tmp/myproject-1.1.67.war',
  timeout     => 0,
  verbose     => false,
}
define tomcat::deployment($path) {

include tomcat
notice("Establishing    http://$hostname:${tomcat::tomcat_port}/$name/")


  file { "/usr/tomcat/apache-tomcat-7.0.57/webapps/${name}.war":
    owner => 'root',
    source => $path,
  }

}

tomcat::deployment { "OptimusPrime":
      path => '/tmp/myproject-1.1.67.war'
   }

file { "/replace_placeholders.sh":
    mode   => 700,
    owner  => root,
    group  => root,
    source => "puppet:///modules/site/replace_placeholders.sh"
}

}
