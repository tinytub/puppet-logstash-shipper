class logstash::files {
	file { "/usr/local/logstash":
		ensure =>  "directory",
		mode => 755,
		owner => root,
		group => root,
		require => Package["jdk-1.7.0_25-fcs.x86_64"],
	}
	file { "/usr/local/logstash/logstash-1.1.13-flatjar.jar":
		ensure => file,
		mode => 755,
		owner => root,
		group => root,
		source => "puppet://$puppetserver/modules/logstash/logstash-1.1.13-flatjar.jar",
		require => File["/usr/local/logstash"],
	}
	file { "/usr/local/logstash/patterns":
                ensure =>  "directory",
                mode => 755,
                owner => root,
                group => root,
		require => File["/usr/local/logstash"];
		"/usr/local/logstash/patterns/grok-patterns":
                ensure => file,
                mode => 755,
                owner => root,
                group => root,
                source => "puppet://$puppetserver/modules/logstash/grok-patterns",
                require => File["/usr/local/logstash/patterns"],
        }

	# Define: agentconf
	# Parameters:
	# arguments
	#
	define agentconf ( $accesspath, $errorpath , $tag1, $tag2) {
        file { 
        "/usr/local/logstash/agent.conf":
        content => template("logstash/agent.conf.erb"),
        owner => "root",
        group => "root",
        mode => "644",
        require => File["/usr/local/logstash"],
        }		
	}

	agentconf { "agent.conf":
	accesspath => $logstash::accesspath,
	errorpath => $logstash::errorpath,
	tag1 => $logstash::tag1,
	tag2 => $logstash::tag2,
	}

	host {"$hostname":
	ip => $ipaddress_eth0,
	ensure => present,	
	}
	
	file {"/etc/init.d/logstash":
	ensure => file,
        mode => 755,
        owner => root,
        group => root,
	source =>"puppet://$puppetserver/modules/logstash/logstash",
        require => File["/usr/local/logstash"],
	}

}
