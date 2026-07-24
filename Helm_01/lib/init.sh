#!/bin/bash

# *** Init
helmname="helm01"
helmdir="./cluster01"

namespace="helmp"
valuesFile="./cluster01/values.yaml"
valuesTemplatefile="./values.template.yaml"

# Website
websiteDir="./simpleWebsite"
websiteImageName="simplewebsite"
websiteImageVersion="0.0.4"
websiteImage="$websiteImageName:$websiteImageVersion"

# Port Frowarding to the Gateway
localport="8080"
