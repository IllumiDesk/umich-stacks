import requests
import pandas as pd
from datetime import datetime


COURSE_SLUG = "rob101-fa-2023"
API_KEY = "38c47c2ad80d3a584b79601b60d9b3b36affd209"
url = f"https://api.illumidesk.com/api/v1/courses/{COURSE_SLUG}/submissions/"

headers = {
    "accept": "application/json",
    "Authorization": f"Token {API_KEY}",
}

# Initialize parameters for pagination
limit = 100
offset = 0
all_data = []  # List to hold all fetched submissions

# Continue fetching while there are more results
while True:
    # Create the URL with pagination parameters
    paginated_url = f"{url}?limit={limit}&offset={offset}"
    
    # Send the GET request
    response = requests.get(paginated_url, headers=headers)
    
    # Check if the request was successful
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json()
        results = data.get('results', [])
        
        # If no more results, break the loop
        if not results:
            break
        
        # Append results to all_data
        all_data.extend(results)
        
        # Update the offset for the next request
        offset += limit
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        break

# Convert the data to a DataFrame
if all_data:
    df = pd.json_normalize(all_data)

    # Generate a unique filename using the current date and time
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    csv_file_name = f"submissions_data_{timestamp}.csv"

    # Save the DataFrame to a CSV file
    df.to_csv(csv_file_name, index=False)
    print(f"All submissions have been saved to CSV file '{csv_file_name}'.")
else:
    print("No data was retrieved.")