#!/bin/sh

# Wait for vote service to be ready
echo "Waiting for vote service..."
until curl -f -s $VOTE_SERVICE_URL > /dev/null 2>&1; do
    echo "Vote service not ready, waiting..."
    sleep 2
done

# Send votes using apache bench
VOTE_URL=$VOTE_SERVICE_URL
echo "Sending 1000 votes for option A..."
ab -n 1000 -c 50 -p posta -T "application/x-www-form-urlencoded" $VOTE_URL/

echo "Sending 1000 votes for option B..."
ab -n 1000 -c 50 -p postb -T "application/x-www-form-urlencoded" $VOTE_URL/

echo "Sending 1000 more votes for option A..."
ab -n 1000 -c 50 -p posta -T "application/x-www-form-urlencoded" $VOTE_URL/

echo "Seeding completed!"