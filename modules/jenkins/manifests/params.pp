# Class: jenkins::params
#
#
class jenkins::params {
#  $version            = 'installed'
  $version            = 'latest'
  $lts                = false
  $repo               = true
  $service_enable     = true
  $service_ensure     = 'running'
  $install_java       = true
  $swarm_version      = '1.9'
}


