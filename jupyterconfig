#!/bin/bash

echo ""
echo ""
echo "===================================="
echo "++++++++++++++++++++++++++++++++++++"
echo "===================================="
echo "This script secures your Notebook Server for access via a web browser"
echo "Please select a secure password for login"
echo "If it is not secure, the Notebook Server is vulnerable to attacks"
echo "Good examples of secure passwords consist of 3 unrelated words"
echo "For example: apple-spring-saxophone"
echo ""

while [ true ]; do
    read -sp 'Please type your password and press enter: ' passvar1
    echo ""
    read -sp 'Please confirm by re-typing: ' passvar2
    echo ""
    if [ $passvar1 != $passvar2 ]; then
        echo "Passwords do not match. Please try again"
        continue
    fi
    if [ ${#passvar1} -lt 8 ]; then
        echo "Your chosen password is too short."
        echo "Please select a password of at least 8 characters."
        continue
    fi
    break
done

#create the password hash
passvarhash=$( echo $passvar1 | sha256sum | awk '{print $1}' )  




