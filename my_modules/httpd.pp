class apache ($disable = "false", $apacheconf = "default") {
  if $disable == "false" {
    $installed = present
    $enable = true
    $ensure = "running"
  } else {
    $installed = absent
    $enable = false
    $ensure = "stopped"
  }
  case $operatingsystem {
    'CentOS', 'RedHat': {
      if $architecture == "x86_64" {
        package { 'httpd':
          name   => "httpd.x86_64",
          ensure => $installed,
        }
      } else {
        package { 'httpd':
          name   => "httpd.i386",
          ensure => $installed,
        }
      }
      service { 'httpd':
        ensure => $ensure,
        enable => $enable,
      }
      file { "http.conf":
        path   => "/etc/httpd/conf/httpd.conf",
        owner  => root,
        group  => root,
        mode   => 0644,
        source => $apacheconf ? {
          'default' => "puppet:///modules/apache/httpd.conf",
        }
      }
    }
  }
}
