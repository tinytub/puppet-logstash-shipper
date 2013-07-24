class logstash::java {
	file { "/tmp/jdk-7u25-linux-x64.rpm":
		ensure => present,
		mode => 755,
		owner => root,
		group => root,
		source => "puppet://$puppetserver/modules/logstash/jdk-7u25-linux-x64.rpm",
	}

	package { "jdk-1.7.0_25-fcs.x86_64":
		provider => rpm,
		ensure => present,
		source => "/tmp/jdk-7u25-linux-x64.rpm",
		require => File["/tmp/jdk-7u25-linux-x64.rpm"],
	}
	
	file { "/etc/profile":
                ensure => present,
                mode => 644,
                owner => root,
                group => root,
                source => "puppet://$puppetserver/modules/logstash/profile",
                require => Package["jdk-1.7.0_25-fcs.x86_64"]
        }

	#exec { "sourceprofile":
	#command => "source /etc/profile",
	#path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
	#refreshonly => true,
	#user => "root",
	#require => File["/etc/profile"],
	#subscribe => File["/etc/profile"],
#	}

}
