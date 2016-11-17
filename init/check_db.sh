#!/usr/bin/env bash

# Because the database will take the most time to initialize, only checking this one.
# If finished the image should be ready to use
ORACLE_ID=$(docker ps -aqf "name=oracle")
LOG_OUTPUT=$(docker logs $ORACLE_ID --tail 1)

while [ "$LOG_OUTPUT" != "Database ready to use. Enjoy! ;)" ]; do
    echo "$(date) - still initializing Oracle DB ( $LOG_OUTPUT )"
    sleep 5
	LOG_OUTPUT=$(docker logs $ORACLE_ID --tail 1)
done

echo "$(date) - Oracle DB sucessfully initialized"