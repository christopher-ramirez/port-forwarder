# Docker Port forwarder

Container for forwarding incoming traffic in one port to an external server.
Since the container works with iptables to set up the traffic forwarding,
it requires the **`NET_ADMIN`** privilege.

The forwarding configuration is set up with environment variables.
These variables define the listening port and the destination server
and optionally, the destination port for the incoming traffic.

### Environment Variables for setting up traffic forwarding
|Variable|Description|
|---|---|
|PORT|Source port of incoming traffic|
|FORWARD_TO|Destination server IP or hostname to forward traffic to|
|FORWARD_TO_PORT|(optional) Destination port where to forward traffic on the destination server. When not defined, it defaults to the same value of $PORT|
|PROTOCOL|(optional) Protocol to use. Default to *tcp*

### Examples

``` sh
  docker run --name port_forwarder            \
             --cap-add=NET_ADMIN              \
             -p 80:80                         \
             -e PORT=80                       \
             -e FORWARD_TO=private.server.com \
             -e FORWARD_TO_PORT=8080          \
             topherafa/port-forwarder
```

Creates a container that forwards incoming traffic in port *80*, to port *8080* on `private.server.com`.
