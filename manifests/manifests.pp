file { "/etc/passwd":
      owner => "root",
      group => "root",
      mode  => "0644",
    }

# install git -- may not need this for drake, will use zip instead
#package { "git-all":
#  ensure => installed;
#}

package { "unzip":
  ensure => installed;
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

# add link to /vagrant to document root
file { '/var/www/html/vagrant':
  ensure => 'link',
  target => '/vagrant',
}

# add index.html file to document root
file { '/var/www/html/index.html':
  owner   => vagrant,
  group   => root,
  mode    => 775,
  ensure  => present,
  source  => "/vagrant/source/httpd/index.html"
}

exec { "curl_lein":
  command => "curl https://raw.github.com/technomancy/leiningen/stable/bin/lein -o /bin/lein",
  path => "/usr/bin/",
  creates => "/bin/lein",
}

file { "/bin/lein":
  mode  => "0755",
}

exec {
  "curl_drake":
    command => "curl -L https://github.com/Factual/drake/archive/develop.zip -o /tmp/drake.zip",
    path => "/usr/bin/",
    creates => "/tmp/drake.zip";

  "unzip_drake":
    cwd => "/opt",
    command => "/usr/bin/unzip /tmp/drake.zip",
    creates => "/opt/drake-develop",
    require => [ Package["unzip"], Exec["curl_drake"] ];

  "build_drake":
    cwd => "/opt/drake-develop",
    command => "/bin/lein uberjar",
    require => [ Exec["unzip_drake"] ];

}

# profit
