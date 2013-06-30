# add a server instance
openvpn::server { 'chicago':
  country      => "US",
  province     => "IL",
  city         => "Chicago",
  organization => "wartenserver.net",
  email        => "hostmaster@wartenserver.net",
  server       => '10.200.200.0 255.255.255.0',
  push         => [ 'redirect-gateway' ],
}

# define clients
openvpn::client { 'swarten':
  server => 'chicago'
}
openvpn::client { 'uwarten':
  server   => 'chicago'
}

# TODO: Add up/down scripts support to openvpn::server and do iptables there
exec { 'iptables -t nat -A POSTROUTING -s 10.200.200.0/24 -o eth0 -j MASQUERADE':
  cwd => "/sbin",
  path => [ "/sbin", "/usr/sbin", "/usr/bin" ],
}

# enable ip_forwarding for ipv4
sysctl::directive {
  "net.ipv4.ip_forward":
    value => 1;
}
