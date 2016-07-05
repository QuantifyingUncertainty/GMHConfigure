#!/bin/bash

#Perform preparation steps to allow to run a cluster of machines (with one master server)
echo "This script configures your GMH Julia Server so it can be used as master of a cluster."
echo "It will add a new public SSH key to your AWS account which is needed to establish"
echo "passwordless connections between the master (the machine you are running the script on)"
echo "and the slaves in the cluster."
echo " "
echo "In preparation, you will need to have created AWS Security Credentials. The script"
echo "will prompt during installation to input your AWS Access Key ID and Secret Access Key ID."
echo "If you are unsure please see the GMHConfigure and AWS documentation for further information."

echo "Do you wish to continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        
            echo "Checking if AWSCLI is installed..."
            which aws
            
            if [ $? -eq 0 ]; then
                echo "AWSCLI package already installed"
            else
                #Install the AWS Command-Line Interface tools
                pip install awscli
            fi

            aws configure set region eu-west-1

            #Configure the AWS CLI
            echo "Please add your AWS Security Credentials"
            echo "Use your Access Key ID and Secret Access Key ID previously downloaded from AWS"
            echo "Make sure that the region corresponds to the region in which you launched this machine" 
            echo "If this is the default region (eu-west-1) you can accept it by pressing [ENTER]"
            echo "You may leave Default Output Format empty and accept it with [ENTER]"
            aws configure

            KEYNAME="julia-cluster-access-"
            KEYNAME+=$(hostname -i)

            KEYFILE="$HOME/.ssh/${KEYNAME}.pem"

            echo "Creating $KEYNAME and adding it to your AWS console"
            aws ec2 create-key-pair --key-name "$KEYNAME" --query 'KeyMaterial' --output text > $KEYFILE
            
            if [ $? -ne 0 ]; then
                echo "If that key is no longer usable, please delete it via the AWS console and run this script again"
                echo "Otherwise, your instance is ready to be used as Master Server in the cluster"
            else
                chmod 600 $KEYFILE
            
                echo "Setting the default IdentityFile to $KEYNAME in .ssh/config"
                echo "IdentityFile $KEYFILE" > $HOME/.ssh/config

                echo "======================================================"
                echo "Instance ready to be used as Master Server in cluster."
                echo "======================================================"
            fi

            exit
            ;;
        No )
            exit
            ;;
    esac
done

