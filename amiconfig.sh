#!/bin/bash

sudo add-apt-repository -y ppa:staticfloat/juliareleases
sudo add-apt-repository -y ppa:staticfloat/julia-deps
sudo apt-get -y update
sudo apt-get -y install build-essential
sudo apt-get -y install hdf5-tools
sudo apt-get -y install julia

julia -e 'include("amiconfig-julia.jl")
