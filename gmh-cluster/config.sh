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
            
            #Install the AWS Command-Line Interface tools
            pip install awscli
            
            aws configure set region eu-west-1
            
            #Configure the AWS CLI
            echo "Please add your AWS Security Credentials"
            echo "Use your Access Key ID and Secret Access Key ID previously downloaded from AWS"
            echo "Make sure that the region corresponds to the region in which you launched this machine" 
            echo "If this is the default region (eu-west-1) you can accept it by pressing [ENTER]"
            echo "You may leave Default Output Format empty and accept it with [ENTER]"
            aws configure
            ;;
        No ) 
            exit
            ;;
    esac
done

echo "AMI ready to be published as a community AMI."
