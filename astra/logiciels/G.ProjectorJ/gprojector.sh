#!/bin/sh
#

SCRIPT=`readlink -f $0`
SCRIPTDIR=`dirname $SCRIPT`

/usr/lib/jvm/java-17-openjdk/bin/java -Xms512m -Xmx2000m -jar $SCRIPTDIR/jars/G.Projector.jar "$@"

