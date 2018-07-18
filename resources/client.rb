resource_name 'maas_client'

property :http_method, Symbol
property :subject, Array
property :param, Hash

action :request do
  require "maas/client"
  con = Maas::Client::MaasClient.new()

  if ['fabrics', 'vlans'].to_set.subset? new_resource.subject.to_set and
      new_resource.http_method == :put
    # When updating vlan object
    primary_rack = {
      'primary_rack' => con.request(:get, ['rackcontrollers'])[0]['system_id']
    }

    result = con.request(
      new_resource.http_method,
      new_resource.subject,
      new_resource.param.merge!(primary_rack)
    )
  else
    result = con.request(
      new_resource.http_method,
      new_resource.subject,
      new_resource.param
    )
  end

  # Default log level of chef-client is warn
  Chef::Log.warn()
  Chef::Log.warn("method: " + new_resource.http_method.to_s)
  Chef::Log.warn("subject: " + new_resource.subject.to_s)
  Chef::Log.warn("param: " + new_resource.param.to_s)
  Chef::Log.warn("response: " + result.to_s)
end

# action_class do
# end
