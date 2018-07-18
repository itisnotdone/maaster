#
# Cookbook:: maaster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'maaster::install'
include_recipe 'maaster::client'
include_recipe 'maaster::configure'
