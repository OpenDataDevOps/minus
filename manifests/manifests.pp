file { "/etc/passwd":
      owner => "root",
      group => "root",
      mode  => "0644",
    }

# install git
package { "git":
  ensure=> installed;
}

# Using git to install Drake
#package { "unzip":
#  ensure => installed;
#}

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

# add leiningen for automating Clojure projects without setting your hair on fire
exec { "curl_lein":
  command => "curl https://raw.github.com/technomancy/leiningen/stable/bin/lein -o /bin/lein",
  path => "/usr/bin/",
  creates => "/bin/lein",
}

file { "/bin/lein":
  mode  => "0755",
}

# add drake, a kind of make for data - http://blog.factual.com/introducing-drake-a-kind-of-make-for-data
exec {

"fetch_drake":
    command => "git clone https://github.com/Factual/drake.git /opt/drake",
    path => "/usr/bin/",
    require => [ Package["git"] ];

  "build_drake":
    cwd => "/opt/drake",
    command => "/bin/lein uberjar",
    require => [  Exec["fetch_drake"], Exec["curl_lein"] ];
}

file { '/bin/drake':
  owner   => root,
  group   => root,
  mode    => 775,
  ensure  => present,
  source  => "/vagrant/source/script/drake"
}

# profit
