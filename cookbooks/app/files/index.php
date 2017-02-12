<?php

// Copy at your own risk license.
// for demo purposes only.

// Function to get the client IP address
function get_client_ip() {
    	$ipaddress = '';
    	if (getenv('HTTP_CLIENT_IP'))
        	$ipaddress = getenv('HTTP_CLIENT_IP');
    	else if(getenv('HTTP_X_FORWARDED_FOR'))
        	$ipaddress = getenv('HTTP_X_FORWARDED_FOR');
    	else if(getenv('HTTP_X_FORWARDED'))
        	$ipaddress = getenv('HTTP_X_FORWARDED');
    	else if(getenv('HTTP_FORWARDED_FOR'))
        	$ipaddress = getenv('HTTP_FORWARDED_FOR');
    	else if(getenv('HTTP_FORWARDED'))
       		$ipaddress = getenv('HTTP_FORWARDED');
    	else if(getenv('REMOTE_ADDR'))
        	$ipaddress = getenv('REMOTE_ADDR');
    	else
        	$ipaddress = 'UNKNOWN';
    	return $ipaddress;
}

$db_server="dbserver";
$db_user="webapp";
$db_access="webapp1234";
$db_name="webportal";

$conn=new mysqli($db_server,$db_user,$db_access,$db_name);
if ($conn->connect_error) {
	die ("DB connection failed: " . $conn->connect_error);
}

$client=get_client_ip();

$sql="insert into page_visitor_ip (ip_addr) values ('$client')";
if (!$conn->query($sql)) {
	die ("DB Error: " . $conn->connect_error);
}

$sql="select count(*) from page_visitor_ip where ip_addr='$client'";
if (!($result=$conn->query($sql))) {
        die ("DB Error: " . $conn->connect_error);
} else {
	$row=$result->fetch_row();
	$hit_count=$row[0];
}

print "<body bgcolor='#FF0000'>";
print "Your IP is $client and you are hitting the site for $hit_count time(s)";
print "</body>";

?>
