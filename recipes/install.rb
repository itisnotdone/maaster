apt_repository 'maas-stable' do
  uri node['maas']['apt']['uri']
  distribution node['lsb']['codename']
  components ['main']
  key node['maas']['apt']['key']
  keyserver 'keyserver.ubuntu.com'
  action :add
end

case node['maas']['install-type']
when 'allinone'
  apt_package 'maas'

when 'separate'

  case node['maas']['role']
  when 'region'
    apt_package 'maas-region-controller'

  when 'rack'
    apt_package 'maas-rack-controller'

  end
end

if node['maas']['install-type'] == 'allinone' or node['maas']['role'] == 'region'
  node['maas']['admin_users'].each do |user|
    execute 'create_admin_users' do
      command "maas createadmin"\
        " --username #{user['username']}"\
        " --password #{user['password']}"\
        " --email #{user['email']}"
      # consider it is done before if rbmaas has been installed.
      not_if { ::File.exist?('/opt/chef/embedded/bin/rbmaas') }
    end
  end
end

if node['maas']['install-type'] == 'allinone' or node['maas']['role'] == 'rack'
  apt_package 'libvirt-bin'

  # should be able to connect target libvirtd via ssh using keypair
end
