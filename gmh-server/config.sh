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

#ensure environment variables are defined
source "$HOME/.profile"

#copy the jupyter notebook config file and store the hashed password into it
SCRIPTDIR=$( dirname $0 )
JUPTEMPLATE=$SCRIPTDIR/jupyter_notebook_config_template.py
JUPCONFIG=$HOME/.jupyter/jupyter_notebook_config.py
HASHVALUE=$( $JUPYTERBIN/ipython -c 'from notebook.auth import passwd; passwd()' | grep sha* )
sed "s@PASSWORDHASH@$HASHVALUE@" <$JUPTEMPLATE >$JUPCONFIG

if [ -e $JUPCONFIG ]; then
    echo "Jupyter configuration file successfully created"
    chmod 600 $JUPCONFIG
else
    echo "Jupyter configuration file not created"
    exit 1
fi

KEYFILE=$HOME/.certificates/jupyterkey.pem
CERTFILE=$HOME/.certificates/jupytercert.pem

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





