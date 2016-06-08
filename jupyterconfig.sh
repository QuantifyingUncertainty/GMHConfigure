#!/bin/bash

echo " "
echo " "
echo "===================================="
echo "++++++++++++++++++++++++++++++++++++"
echo "===================================="
echo "This script secures your Notebook Server for access via a web browser"
echo "Please select a secure password for login"
echo "If it is not secure, the Notebook Server is vulnerable to attacks"
echo "Good examples of secure passwords consist of 3 unrelated words"
echo "For example: apple-spring-saxophone"
echo " "

while [ true ]; do
    read -sp 'Please type your password and press enter: ' PASSVAR1
    echo " "
    read -sp 'Please confirm by re-typing: ' PASSVAR2
    echo " "
    if [ $PASSVAR1 != $PASSVAR2 ]; then
        echo "Passwords do not match. Please try again"
        continue
    fi
    if [ ${#PASSVAR1} -lt 8 ]; then
        echo "Your chosen password is too short."
        echo "Please select a password of at least 8 characters."
        continue
    fi
    break
done

#create the password hash
PASSVARHASH=$( echo $PASSVAR1 | sha256sum | awk '{print $1}' )

#copy the jupyter notebook config file and store the hashed password into it
SCRIPTDIR=$( dirname $0 )
JUPTEMPLATE=$SCRIPTDIR/jupyter_notebook_config_template.py
JUPCONFIG=~/.jupyter/juptyer_notebook_config.py

sed "s/PASSWORDHASH/$PASSVARHASH/" <$JUPTEMPLATE >$JUPCONFIG

if [ -e $JUPCONFIG ]; then
    echo "Jupyter configuration file successfully created"
    chmod 600 $JUPCONFIG
else
    echo "Jupyter configuration file not created"
    exit 1
fi

KEYFILE=~/.certificates/jupyterkey.pem
CERTFILE=~/.certificates/jupytercert.pem

echo "Creating an SSL certificate for browser access"
echo "Accept the default values by pressing [ENTER]"
if [ ! -e $KEYFILE ] && [ ! -e $CERTFILE ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEYFILE -out $CERTFILE
fi
if [ -e $KEYFILE ] && [ -e $CERTFILE ]; then
    echo "SSL certificate successfully created"
    chmod 400 $KEYFILE $CERTFILE
else
    echo "SSL certificate not created"
fi

echo "===================================="
echo "++++++++++++++++++++++++++++++++++++"
echo "===================================="
echo " "
echo "Jupyter Notebook Server successfully configured."
echo "You may now launch it by typing:"
echo "  jupyter notebook &"
echo " "
echo "===================================="
echo "++++++++++++++++++++++++++++++++++++"
echo "===================================="

    

    





