#!/bin/bash

usage() {
    echo "Usage: $0 [-u URL] [-c CURRENCY]"
    echo "  -u URL”
    echo "  -c CURRENCY”
    exit 1
}

read -p "Enter URL: " URL
read -p "Enter Currency: " CURRENCY

URL=${URL:-""}
CURRENCY=${CURRENCY:-""}

while getopts "u:c:" opt; do
    case ${opt} in
        u)
            URL=${OPTARG}
            ;;
        c)
            CURRENCY=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

response=$(curl -s ${URL})

echo "Raw API Response: $response"

if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch data from API."
    exit 1
fi

updated_time=$(echo ${response} | jq -r '.time.updated')
rate=$(echo ${response} | jq -r ".bpi.${CURRENCY}.rate")

if [ -z "$updated_time" ] || [ -z "$rate" ]; then
    echo "Error: Failed to parse the required information from the API response."
    exit 1
fi

echo "Time Updated: $updated_time"
echo "Rate (${CURRENCY}): $rate"

exit 0 
