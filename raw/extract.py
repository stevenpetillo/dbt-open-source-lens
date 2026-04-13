########################################################
# extract.py - Extract Raw data from API in JSON format
########################################################

# Import Libaries
import requests
import json
import os
from datetime import datetime

# Variables
BASE_URL = "https://api.github.com"
OWNER = "dbt-labs"
REPO = "dbt-core"

# Not needed right now
token = os.getenv("GITHUB_TOKEN")

# Output Type
headers = {
    "Accept": "application/vnd.github+json"
}

print("    Authorizing...")

# Authorization
if token:
    headers["Authorization"] = f"Bearer {token}"

# Functions
def fetch_issues():
    page = 1
    all_issues = []

    while True:
        url = f"{BASE_URL}/repos/{OWNER}/{REPO}/issues"
        params = {
            "state": "all",
            "per_page": 100,
            "page": page
        }

        response = requests.get(url, headers=headers, params=params)

        data = response.json()
        all_issues.extend(data)

        if len(data) < 100:
            break

        page += 1

    return all_issues

print("    Fetching...")

if __name__ == "__main__":
    issues = fetch_issues()

    with open("extract.json", "w") as f:
        json.dump(issues, f, indent=2)

    print(f"    Fetched {len(issues)} issues")
