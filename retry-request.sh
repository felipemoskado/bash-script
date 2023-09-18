#!/bin/bash

response=$(curl --location 'localhost:8080/api/health' --header 'Content-Type: application/json' --data '1' --retry 3 --retry-delay 1)
echo "response: $response"


###################################
# Using jq
# Needs to install jq

count=0
response=""
maxRetry=$1
delay=$2

while [[ $count -lt $maxRetry ]]
do 
  response=$(curl --location 'localhost:8080/api/categories' --header 'Content-Type: application/json' --data '{"name": "Pizza"}')
  # response=$(curl --location 'localhost:8080/api/health' --header 'Content-Type: application/json' --data '2')
  echo "response: $response"

  count=$(( $count + 1 ))
  status=$(echo $response | jq -r '.statusCode')
  type=$(echo $response | jq -r '.type')

  echo "[count: $count - status: $status - type: $type]"

  if [ "$type" != "INTERNAL_SERVER_ERROR" ]; then
    echo "Saindo sem retentativa."
    exit 0
  fi

  sleep $delay
done


###################################
# Using jq
# Needs to install jq

count=0
response=""
maxRetry=$1
delay=$2

while [[ $count -lt $maxRetry ]]
do 
  response=$(curl --location 'localhost:8080/api/categories' --header 'Content-Type: application/json' --data '{"name": "Pizza"}')
  count=$(( $count + 1 ))
  error=$(echo $response | jq -r '.error')
  code=$(echo $error | jq -r '.code')
  message=$(echo $error | jq -r '.message')

  echo "[count: $count - code: $code - message: $message]"

  if [ "$code" != "502" && "$message" != "internalServerError" ]; then
    echo "Saindo sem retentativa."
    exit 0
  fi

  sleep $delay
done
