file { "/etc/passwd":
      owner => "root",
      group => "root",
      mode  => "0644",
    }

# install apache/httpd
package { "httpd":
  ensure => installed;
}

# install open-jdk 1.6
package{"java-1.6.0-openjdk-devel":
  ensure=>latest
}

# install tomcat & co.
package {["tomcat6", "tomcat6-webapps", "tomcat6-admin-webapps"]:
  ensure =>"present"
}

# start httpd
service { "httpd":
  enable => "true",
  ensure => "running",
  hasrestart => "true",
  hasstatus => "true",
}

# start tomcat
service { "tomcat6":
  enable => "true",
  ensure => "running",
  hasrestart => "true",
  hasstatus => "true",
}

# disable pesky iptables. ick security!
exec { "disable_iptable":
  command => "iptables save",
  path => "/etc/init.d/",
}

exec { "disable_iptable1":
  command => "iptables stop",
  path => "/etc/init.d/",
}

exec { "disable_iptable2":
  command => "chkconfig iptables off",
  path => "/sbin/",
}

# profit
