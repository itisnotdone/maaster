name 'maaster'
default_source :supermarket
default_source :chef_repo, '../' do |s|
  s.preferred_for 'maaster'
end

run_list 'maaster'
instance_eval(IO.read("policies/maaster.rb"))
