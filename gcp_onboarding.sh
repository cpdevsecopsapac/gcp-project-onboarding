#!/bin/bash

# Put your project ID here
project_id="your_project_id"

# List of all services to be enabled
services=(
"compute.googleapis.com"
"cloudresourcemanager.googleapis.com"
"container.googleapis.com"
"cloudkms.googleapis.com"
"iam.googleapis.com"
"appengine.googleapis.com"
"bigquery.googleapis.com"
"admin.googleapis.com"
"cloudfunctions.googleapis.com"
"sqladmin.googleapis.com"
"bigtableadmin.googleapis.com"
"pubsub.googleapis.com"
"redis.googleapis.com"
"serviceusage.googleapis.com"
"file.googleapis.com"
"apikeys.googleapis.com"
"logging.googleapis.com"
"dns.googleapis.com"
"cloudasset.googleapis.com"
"essentialcontacts.googleapis.com"
"accessapproval.googleapis.com"
)

# Enable all services
for service in "${services[@]}"; do
    gcloud services enable $service --project=$project_id
done

# Create service account
gcloud iam service-accounts create CloudGuard-Connect --project=$project_id

# Add IAM policy bindings
gcloud projects add-iam-policy-binding $project_id --member serviceAccount:CloudGuard-Connect@$project_id.iam.gserviceaccount.com --role roles/viewer
gcloud projects add-iam-policy-binding $project_id --member serviceAccount:CloudGuard-Connect@$project_id.iam.gserviceaccount.com --role roles/iam.securityReviewer
gcloud projects add-iam-policy-binding $project_id --member serviceAccount:CloudGuard-Connect@$project_id.iam.gserviceaccount.com --role roles/cloudasset.viewer

# Create service account key
gcloud iam service-accounts keys create ~/key.json --iam-account CloudGuard-Connect@$project_id.iam.gserviceaccount.com --project=$project_id

# Display the key
cat ~/key.json

