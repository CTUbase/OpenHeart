from typing import TypedDict
import requests  # Import requests to make HTTP requests


# Define the resource type for supabase
class supabase(TypedDict):
    key: str
    url: str


def main():
    # Extract the key and url from the supabase resource
    key = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBndHF4d2t0ZGxidmxpeGxvYmlzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMTMzMzQ2NiwiZXhwIjoyMDQ2OTA5NDY2fQ.rxv6Nff4vMBHrjC_9FIL7ZWdK7CaoILNYBN1XinjBhQ'
    url = 'https://pgtqxwktdlbvlixlobis.supabase.co'

    # Define the endpoint for the 'book' table
    endpoint = f"{url}/rest/v1/book"

    # Set up the headers with the API key for authentication
    headers = {
        "apikey": key,
        "Authorization": f"Bearer {key}",
        "Content-Type": "application/json",
    }

    # Make a GET request to the endpoint to retrieve the 'book' table data
    response = requests.get(endpoint, headers=headers)

    # Check if the request was successful
    if response.status_code == 200:
        # Return the JSON response if successful
        return response.json()
    else:
        # Return an error message if the request failed
        return {"error": f"Failed to retrieve data: {response.status_code}"}
