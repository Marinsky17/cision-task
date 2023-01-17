#!/bin/bash

# Although this would actually be part of a much larger script, it fits the requirements of the task.
# In this case, we use a combination of Bash and the native google cloud shell. 

###---PLEASE NOTE THIS EXAMPLE IS RELATED OT GOOGLE CLOUD PLATFORM---###

# TF_VAR_project_id is a global variable, that sets the value of the project we would like to use (in GCP, for example)
# $TF_VAR_project_id = "production-env"

echo > 
gcloud projects get-iam-policy $TF_VAR_project_id | grep etag >> service-account-policy.yml # Grep the etag for our general service account policy
cat service-account-policy.yml

# Our aim is to update our service account with owner permissions.
echo "bindings:
    - members:
      - serviceAccount:terraform-authenticator@$TF_VAR_project_id.iam.gserviceaccount.com
      role: projects/$TF_VAR_project_id/roles/owner" > service-account-policy.yml

