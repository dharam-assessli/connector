#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'development' or 'production'."
  exit 1
fi

case $1 in
  development)
    flutterfire config \
      --project=assei-apps-development \
      --out=lib/firebase_options/firebase_options_development.dart \
      --ios-bundle-id=com.assessli.connector.development \
      --ios-out=ios/flavors/development/GoogleService-Info.plist \
      --android-package-name=com.assessli.connector.development \
      --android-out=android/app/src/development/google-services.json
    ;;

  staging)
    flutterfire config \
      --project=assei-apps-staging \
      --out=lib/firebase_options/firebase_options_staging.dart \
      --ios-bundle-id=com.assessli.connector.staging \
      --ios-out=ios/flavors/staging/GoogleService-Info.plist \
      --android-package-name=com.assessli.connector.staging \
      --android-out=android/app/src/staging/google-services.json
    ;;

  production)
    flutterfire config \
      --project=assei-apps-production \
      --out=lib/firebase_options/firebase_options_production.dart \
      --ios-bundle-id=com.assessli.connector \
      --ios-out=ios/flavors/production/GoogleService-Info.plist \
      --android-package-name=com.assessli.connector \
      --android-out=android/app/src/production/google-services.json
    ;;

  *)

    echo "Error: Invalid environment specified. Use 'development' or 'staging' or 'production'."
    exit 1
    ;;

esac

# Make the script executable:
# chmod +x flutterfire-config.sh

# Run the script for the development environment:
# ./flutterfire-config.sh development

# Run the script for the staging environment:
# ./flutterfire-config.sh staging

# Run the script for the production environment:
# ./flutterfire-config.sh production
