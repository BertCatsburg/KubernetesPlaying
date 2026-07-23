#!/bin/bash

# *** Init
helmname="helm01"
helmdir="./cluster01"
namespace="helmp"
websiteDir="./simpleWebsite"
websiteImageName="simplewebsite"
websiteImageVersion="0.0.3"
websiteImage="$websiteImageName:$websiteImageVersion"
valuesFile="./cluster01/values.yaml"
valuesTemplatefile="./values.template.yaml"
