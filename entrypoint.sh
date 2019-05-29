#! /bin/sh

if ! [ $FORWARD_TO ]; then
    echo "FORWARD_TO environment variable is not set"
    exit 1
fi

if ! [ $PORT ]; then
    echo "PORT environment variable is not set"
    exit 1
fi

FORWARD_TO=$(getent hosts $FORWARD_TO | cut -d ' ' -f1)
PROTOCOL=${PROTOCOL:-'tcp'}
FORWARD_PORT=${FORWARD_TO_PORT:-$PORT}
CONTAINER_IP=$(hostname -i)

# Setup IPTables
iptables -t nat -A PREROUTING -p $PROTOCOL --dport $PORT -j DNAT --to-destination $FORWARD_TO:$FORWARD_PORT
iptables -t nat -A POSTROUTING -p $PROTOCOL -d $FORWARD_TO --dport $FORWARD_PORT -j SNAT --to-source $CONTAINER_IP

echo "Waiting and forwarding connections..."

trap : TERM INT; while sleep 3600; do :; done & wait
