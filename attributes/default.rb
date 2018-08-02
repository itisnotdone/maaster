default['maas']['apt']['uri'] =
  'http://ppa.launchpad.net/maas/stable/ubuntu'
default['maas']['apt']['key'] = '684D4A1C'
default['maas']['install-type'] = 'allinone'

if default['maas']['install-type'] == 'separate'
  default['maas']['role'] = 'region'
  # or default['maas']['role'] = 'rack'
end

default['maas']['admin_users'] = [
  {
    "username" => "admin1",
    "password" => "password1",
    "email" => "admin1@domain.org"
  },
]

# for whom to prepare rbmaas configuration
default['maas']['rbmaas']['users'] = ['root', 'don']

# Configure ipranges depending on network info as follow
# https://github.com/itisnotdone/easeovs/tree/master/template
default['maas']['default_domain'] = 'argn.don'

# https://docs.maas.io/2.3/en/api
default['maas']['config'] = {
  'main_archive' => 'http://archive.ubuntu.com/ubuntu/',
  'active_discovery_interval' => '',
  'boot_images_auto_import' => '',
  'commissioning_distro_series' => '',
  'completed_intro' => '',
  'curtin_verbose' => '',
  'default_distro_series' => '',
  'default_dns_ttl' => '',
  'default_min_hwe_kernel' => '',
  'default_osystem' => '',
  'default_storage_layout' => '',
  'disk_erase_with_quick_erase' => '',
  'disk_erase_with_secure_erase' => '',
  'dnssec_validation' => '',
  'enable_analytics' => '',
  'enable_disk_erasing_on_release' => '',
  'enable_http_proxy' => '',
  'enable_third_party_drivers' => '',
  'http_proxy' => '',
  'kernel_opts' => '',
  'maas_name' => default['maas']['default_domain'],
  'max_node_commissioning_results' => '',
  'max_node_installation_results' => '',
  'max_node_testing_results' => '',
  'network_discovery' => '',
  'ntp_external_only' => '',
  'ntp_servers' => '',
  'subnet_ip_exhaustion_threshold_count' => '',
  'upstream_dns' => '8.8.8.8',
  'use_peer_proxy' => '',
  'windows_kms_host' => ''
}
# 'maas_name' stands for region name

default['maas']['ipranges'] = [
  {
    type: 'dynamic',
    start_ip: '172.30.2.101',
    end_ip: '172.30.2.254',
    comment: 'for some purpose'
  },
  {
    type: 'reserved',
    start_ip: '172.30.2.1',
    end_ip: '172.30.2.10',
    comment: 'for some purpose'
  }
]

# to enable dhcp_on
# Fabric ID(fid) and VLAN ID(vid)
default['maas']['dhcp_on'] = [
  {
    fid: 0,
    vid: 0
  }
]

default['maas']['dnsresources'] = [
  {
    name: 'argn-www',
    domain: 'argn.don',
    ip_addresses: '172.30.2.4'
  }
]

default['maas']['pods'] = [
  {
    type: 'virsh',
    name: 'dev-kvm',
    power_address: 'qemu+ssh://don@172.30.2.1/system'
  }
]
