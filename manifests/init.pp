class logstash {
#$accesspath = "/export/home/webserver/nginxlogs/*access*"
#$errorpath = "/export/home/webserver/nginxlogs/*error*"
#$tag1 = "GZ-weilaiTV-access"
#$tag2 = "GZ-weilaiTV-error"

include logstash::java
include logstash::files

service {"logstash":
  ensure => "running",
  enable => true,
  require => [Package["jdk-1.7.0_25-fcs.x86_64"],
		File["/usr/local/logstash/logstash-1.1.13-flatjar.jar"],
		Host["$hostname"],File["/etc/init.d/logstash"],
		File["/usr/local/logstash/agent.conf"],
		File["/usr/local/logstash/patterns/grok-patterns"]],
  subscribe => File["/usr/local/logstash/agent.conf"],
}
}

