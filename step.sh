#!/bin/bash

# exit if a command fails
set -e

#
# Required parameters
if [ -z "${app_path}" ] ; then
  echo " [!] Missing required input: app_path"
  exit 1
fi
if [ ! -f "${app_path}" ] ; then
  echo " [!] File doesn't exist at specified path: ${app_path}"
  exit 1
fi
if [ -z "${app_center_app}" ] ; then
  echo " [!] Missing required input: app_center_app"
  exit 1
fi
if [ -z "${app_center_token}" ] ; then
  echo " [!] Missing required input: app_center_token"
  exit 1
fi


# ---------------------
# --- Configs:

echo " (i) Provided app path: ${app_path}"
echo " (i) Provided app center app: ${app_center_app}"
echo " (i) Provided app center token: 4cf23d2f1d9c268284ace5a1cc8bd374f4271b64"
echo

# ---------------------
# --- Main

ARTIFACTS_DIR="Artifacts"
BUILD_DIR="Petco.UITests/bin/Release"
MANIFEST_PATH="${ARTIFACTS_DIR}/manifest.json"


#SOLUTION="Petco.UITests.sln"
npm install appcenter-cli@1.0.8 -g
#nuget restore -NonInteractive "${SOLUTION}"
msbuild "Petco.UITests/Petco.UITests.csproj" /p:Configuration=Release
#appcenter test run uitest --app "${app_center_app}" --devices 6f2c8184 --app-path "${app_path}" --async --fixture Petco.UITests.Cart\(Android\).VerifyCartFlowSecureCheckOutForgotPasswordwithOutRepeatDelivery --test-series "master" --locale "en_US" --token "${app_center_token}" --build-dir "Petco.UITests/bin/Release"

#npm install appcenter-cli@1.0.8 -g
#appcenter test generate uitest --platform android --output-path "${OUTPUT_PATH}"
#nuget restore -NonInteractive "${SOLUTION}"
#msbuild "${SOLUTION}" /p:Configuration=Release
appcenter test prepare uitest --artifacts-dir "${ARTIFACTS_DIR}" --app-path "${app_path}" --build-dir "${BUILD_DIR}" --fixture "Petco.UITests.AM_ProfileLanding(iOS).VerifyProfileLanding" --fixture "Petco.UITests.Cart(iOS).VerifyCartFlowSecureCheckOutForgotPasswordwithOutRepeatDelivery" --debug --quiet
appcenter test run manifest --manifest-path "${MANIFEST_PATH}" --app "${app_center_app}" --devices "rashmi.padhi-01/apple-iphone-7-plus" --test-series "master" --locale "en_US" --debug --quiet --token "${app_center_token}"


