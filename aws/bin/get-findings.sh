#!/bin/sh
printf "Output from Cloud Functions logs:\n"
# LOG_STREAM=$(aws logs describe-log-streams --log-group-name '/aws/lambda/MyFunction' --query logStreams[*].logStreamName)
# aws logs get-log-events --log-group-name '/aws/lambda/MyFunction' --log-stream-name $LOG_STREAM | grep -E 'Threat|Verdict'
LOG_GROUP=/aws/lambda/[YOUR-LAMBDA-NAME]
LOG_STREAM=`aws logs describe-log-streams --log-group-name $LOG_GROUP --max-items 1 --order-by LastEventTime --descending --query logStreams[].logStreamName --output text | head -n 1`
aws logs get-log-events --log-group-name $LOG_GROUP --log-stream-name $LOG_STREAM --query events[].message --output text
