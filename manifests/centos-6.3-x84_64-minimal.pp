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

exec { "disable_iptable": command => "iptables save", path => "/etc/init.d/", } exec { "disable_iptable1": command => "iptables stop", path => "/etc/init.d/", } exec { "disable_iptable2": command => "chkconfig iptables off", path => "/sbin/", }
