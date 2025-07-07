#!/bin/sh

# Set default values if environment variables are not provided
VOTES_A=${VOTES_A:-1000}
VOTES_B=${VOTES_B:-1000}

echo "Configuration:"
echo "  Votes for option A: $VOTES_A"
echo "  Votes for option B: $VOTES_B"

# Wait for vote service to be ready
echo "Waiting for vote service..."
until curl -f -s $VOTE_SERVICE_URL > /dev/null 2>&1; do
    echo "Vote service not ready, waiting..."
    sleep 2
done

# Send votes using apache bench
VOTE_URL=$VOTE_SERVICE_URL
echo "Sending $VOTES_A votes for option A..."
ab -n $VOTES_A -c 50 -p posta -T "application/x-www-form-urlencoded" $VOTE_URL/

echo "Sending $VOTES_B votes for option B..."
ab -n $VOTES_B -c 50 -p postb -T "application/x-www-form-urlencoded" $VOTE_URL/

echo "Seeding completed!"
echo "Total votes sent: $((VOTES_A + VOTES_B)) ($VOTES_A for A, $VOTES_B for B)"