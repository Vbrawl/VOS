
# What is /etc/protocols

The /etc/protocols file contains information about protocols used by DARPA Internet.
Basically, it contains all known protocols used on the internet.

Initially, the contents of this file should be fetched from IANA (https://www.iana.org/assignments/protocol-numbers/protocol-numbers-1.csv)

# Formatting

```
protocol_name protocol_number aliases # comment
```

1) `protocol_name` - Official protocol name
2) `protocol_number` - Official protocol number
3) `aliases` - Other names for the protocol
4) `comment` - Text for humans

# Updating

To update the /etc/protocols file before building VOS you need to run:

```
source environment.sh
$ROOT/update-protocols.sh
```
