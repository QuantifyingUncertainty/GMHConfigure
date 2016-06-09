#!/bin/bash

echo " "
echo "======================================================================="
echo "This script prepares the AMI for publication."
echo "It removes existing SSL certificates, Jupyter configurations and passwords, AWS and SSH access keys."
echo "After logout, you will not be able to establish another login session to the same machine."

echo "Do you wish to continue? Please type in the corresponding number:"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            #remove certificates that have been created to access the Jupyter server
	    echo "Removing SSL certificates..."
            rm -i ~/.cerficates/*

            #remove Jupyter config files that contain hashed passwords
            echo "Removing Jupyter configuration files..."
            rm -i ~/.jupyter/*

            #remove AWS configuration files
            echo "Removing AWS configuration files..."
            rm -i ~/.aws/*

            #remove GIT configuration file
	    if [ -e ~/.gitconfig ]; then
                echo "Removing GIT configuration file..."
		rm -i ~/.gitconfig
            fi

            #remove the history and SSH command keys with which the instance was started
            echo "Removing SSH keys and cleaning history..."
            sudo find ~/.*history -exec rm -f {} \;
            sudo find /root/.ssh/authorized_keys -exec rm -f {} \;
            sudo find ~/.ssh/authorized_keys -exec rm -f {} \;

	    echo "This instance is now ready to be published as a community AMI"
            echo "Please refer to the GMH documentation for further details"
            ;;
        No )
            echo "No modifications have been made to this instance."
            exit
            ;;
    esac
done



