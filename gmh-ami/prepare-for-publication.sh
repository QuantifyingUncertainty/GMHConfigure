#!/bin/bash

echo "This script prepares the AMI for publication."
echo "It will remove existing SSL certificates, jupyter configurations and passwords, and SSH access keys."
echo "After logout, you will not be able to re-establish another login session to the same machine."

echo "Do you wish to continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            #remove certificates that have been created to access the Jupyter server
            rm -i ~/.cerficates/*

            #remove Jupyter config files that contain hashed passwords
            rm -i ~/.jupyter/*

            #remove the history and SSH command keys with which the instance was started
            sudo find ~/.*history -exec rm -f {} \;
            sudo find /root/.ssh/authorized_keys -exec rm -f {} \;
            sudo find ~/.ssh/authorized_keys -exec rm -f {} \;
            ;;
        No ) 
            exit
            ;;
    esac
done

echo "AMI ready to be published as a community AMI."



