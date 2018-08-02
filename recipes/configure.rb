# to do initial configurations
node['maas']['config'].each do |key, value|
  unless value.empty?
    maas_client 'maas-client' do
      http_method :post
      subject ['maas']
      param ({
        'op' => 'set_config',
        'name' => key,
        'value' => value
      })
    end
  end
end

# to print the result of configiration
node['maas']['config'].each do |key, value|
  maas_client 'maas-client' do
    http_method :get
    subject ['maas']
    param ({
      'op' => 'get_config',
      'name' => key
    })
  end
end

# to set default domain instead of 'maas'
maas_client 'default-domain' do
  http_method :put
  subject ['domains', 0]
  param ({
    'name' => node['maas']['default_domain'],
  })
end

# to configure ipranges
node['maas']['ipranges'].each do |range|
    maas_client 'iprange' do
      http_method :post
      subject ['ipranges']
      param ({
        'type' => range[:type],
        'start_ip' => range[:start],
        'end_ip' => range[:end],
        'comment' => range[:comment],
      })
      ignore_failure true
    end
end if node['maas']['ipranges']

# to configure dhcp_on
# the resource will automatically find out the 'system_id' of 'primary_rack'
node['maas']['dhcp_on'].each do |target|
    maas_client 'dhcp_on' do
      http_method :put
      subject ['fabrics', target[:fid], 'vlans', target[:vid]]
      param ({
        'dhcp_on' => true,
      })
      ignore_failure true # for now
    end
end if node['maas']['dhcp_on']

# to configure dnsresources
node['maas']['dnsresources'].each do |dnsresource|
    maas_client 'dnsresource' do
      http_method :post
      subject ['dnsresources']
      param dnsresource
      ignore_failure true # for now
    end
end if node['maas']['dnsresources']

# to configure pods
# need to follow directions below.
# https://docs.maas.io/2.3/en/nodes-add
node['maas']['pods'].each do |pod|
    maas_client 'pod' do
      http_method :post
      subject ['pods']
      param pod
      ignore_failure true # for now
    end
end if node['maas']['pods']
