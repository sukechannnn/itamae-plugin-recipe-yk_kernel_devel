package 'wget'

kernel_version = run_command("uname -r").stdout.gsub(/\n/, "")
p kernel_version

rpm_packages_version = run_command("rpm -qa")
kernel_devel_wrong_version = rpm_packages_version.stdout.match(/kernel-devel-.*/).to_s
p kernel_devel_wrong_version

kernel_devel_expected_version = "kernel-devel-#{kernel_version}"
p kernel_devel_expected_version

if kernel_version != kernel_devel_wrong_version.gsub(/kernel-devel-/, "")
  execute "rpm -e --nodeps #{kernel_devel_wrong_version}" do
    only_if 'rpm -qa | grep kernel-devel'
  end
end

unless run_command("grep exclude=kernel* /etc/yum.conf").stdout.include?('#')
  file '/etc/yum.conf' do
    action :edit
    block do |content|
      content.gsub!('exclude=kernel*', '# exclude=kernel*')
    end
  end
end

local_ruby_block 'install kernel-devel by yum' do
  block do
    run_command("sudo yum install #{kernel_devel_expected_version}", error: false)
  end
  not_if 'rpm -qa | grep kernel-devel'
end

local_ruby_block 'install kernel-devel by rpm' do
  block do
    run_command("wget \"ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/#{node[:platform_version][0..2]}/x86_64/os/Packages/#{kernel_devel_expected_version}.rpm\"", error: false)
  end
  not_if 'rpm -qa | grep kernel-devel'
  not_if 'ls | grep kernel-devel'
end

execute "rpm -ivh #{kernel_devel_expected_version}.rpm" do
  not_if 'rpm -qa | grep kernel-devel'
  only_if 'ls | grep kernel-devel'
end

local_ruby_block 'check kernel-devel install' do
  block do
    rpm_packages_version = run_command("rpm -qa")
    kernel_devel_version = rpm_packages_version.stdout.match(/kernel-devel-.*/).to_s
    p kernel_devel_version

    if kernel_version == kernel_devel_version.gsub(/kernel-devel-/, "")
      puts 'kernel-devel is installed'
    else
      puts 'Error : Could not install kernel-devel. You need to install by yourself, sorry.'
    end
  end
end
