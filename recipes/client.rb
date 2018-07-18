chef_gem 'maas-client'

ruby_block 'get_a_user_key' do
  block do
    akey = `maas apikey --username #{node['maas']['admin_users'][0]['username']} | tr '\n' ' '`
    node.force_default['maas']['admin_users'][0]['key'] = akey.chop!
  end
  action :run
end

node['maas']['rbmaas']['users'].each do |user|
  directory "#{`echo ~#{user}`.chop!}/.rbmaas" do
    owner user
    group user
    mode '750'
    action :create
  end

  template "#{`echo ~#{user}`.chop!}/.rbmaas/rbmaas.yml" do
    source 'rbmaas.yml.erb'
    owner user
    group user
    mode '600'
  end
end

# https://github.com/typhoeus/typhoeus/issues/390
apt_package 'libcurl4-openssl-dev'
