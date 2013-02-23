file { '/etc/passwd':
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }

package { httpd: ensure => installed; }

service { "httpd":
enable => "true",
ensure => "running",
hasrestart => "true",
hasstatus => "true",
}

package{'java-1.6.0-openjdk-devel':ensure=>latest}
package {['tomcat6', 'tomcat6-webapps', 'tomcat6-admin-webapps']:ensure =>'present' }
service { "tomcat6":
enable => "true",
ensure => "running",
hasrestart => "true",
hasstatus => "true",
}

exec { "disable_iptable": command => "iptables save", path => "/etc/init.d/", } exec { "disable_iptable1": command => "iptables stop", path => "/etc/init.d/", } exec { "disable_iptable2": command => "chkconfig iptables off", path => "/sbin/", }
