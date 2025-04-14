#!/bin/bash

PROG=$1
PROGNAME=$(basename $PROG)

(time $PROG) > $LOGS/$PROGNAME.1 2> $LOGS/$PROGNAME.2
STATUS=$?

mv $LOGS/$PROGNAME.1 $LOGS/$PROGNAME.1.$STATUS
mv $LOGS/$PROGNAME.2 $LOGS/$PROGNAME.2.$STATUS
