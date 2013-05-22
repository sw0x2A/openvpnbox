# add a server instance
openvpn::server { 'chicago':
  country      => "US",
  province     => "IL",
  city         => "Chicago",
  organization => "wartenserver.net",
  email        => "hostmaster@wartenserver.net",
  server       => '10.200.200.0 255.255.255.0'
}

# define clients
openvpn::client { 'swarten':
  server => 'chicago'
}
openvpn::client { 'uwarten':
  server   => 'chicago'
}

# enable ip_forwarding for ipv4
sysctl::directive {
  "net.ipv4.ip_forward":
    value => 1;
}
