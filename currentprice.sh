#!/bin/bash

usage() {
    echo "Usage: $0 [-u URL] [-c CURRENCY]"
    echo "  -u URL"
    echo "  -c CURRENCY"
    exit 1
}

# Prompt the user for input
read -p "Enter URL: " URL
read -p "Enter Currency: " CURRENCY

# Parse command line arguments
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

# Ensure both URL and CURRENCY are provided
if [ -z "${URL}" ] || [ -z "${CURRENCY}" ]; then
    usage
fi

# Fetch the data from the API
response=$(curl -s "${URL}")

# Print the raw response for debugging purposes
echo "Raw API Response: $response"

# Check if the API request was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch data from API."
    exit 1
fi

# Parse the response using jq to extract the required information
updated_time=$(echo "${response}" | jq -r '.time.updated')
rate=$(echo "${response}" | jq -r ".bpi.${CURRENCY}.rate")

# Check if the extraction was successful
if [ -z "$updated_time" ] || [ -z "$rate" ]; then
    echo "Error: Failed to parse the required information from the API response."
    exit 1
fi

# Display the extracted information
echo "Time Updated: $updated_time"
echo "Rate (${CURRENCY}): $rate"

exit 0
