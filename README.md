# Scripting_Challenge

**User Input**
The script prompts the user for the API URL and currency if not provided via command-line arguments.
**Command-Line Overrides**
Command-line arguments (-u and -c) can override the user input.
**API Request**
The script fetches data from the specified API URL using curl.
**Response Validation**
It checks if the API request was successful.
**JSON Parsing**
The script uses jq to parse the JSON response and extract the required fields (updated_time and rate).
**Validation**
It checks if the parsing was successful.
**Output**
The script prints the extracted information and exits.
