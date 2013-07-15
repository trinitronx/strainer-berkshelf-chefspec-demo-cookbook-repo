# simple search

u = data_bag_item("users", "demo")

if u['ssh_keys']
  template "/home/#{u['id']}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['uid']
    group u['gid'] || u['id']
    variables( :ssh_keys => u['ssh_keys'] )
    mode 0600
    not_if {u.empty?}
    action :create # must have action, chefspec will not default action :create
  end
end
