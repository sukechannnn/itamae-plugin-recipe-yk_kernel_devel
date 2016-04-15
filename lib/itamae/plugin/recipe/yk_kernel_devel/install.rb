package 'wget'

kernel_version = run_command("uname -r").stdout.gsub(/\n/, "")
p kernel_version

rpm_packages_version = run_command("rpm -qa")
kernel_devel_wrong_version = rpm_packages_version.stdout.match(/kernel-devel-.*/).to_s
p kernel_devel_wrong_version

if kernel_version != kernel_devel_wrong_version.gsub(/kernel-devel-/, "")
  execute "rpm -e --nodeps #{kernel_devel_wrong_version}" do
    only_if 'rpm -qa | grep kernel-devel'
  end
end

kernel_devel_expected_version = "kernel-devel-#{kernel_version}"

execute "wget \"ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/6.4/x86_64/updates/security/#{kernel_devel_expected_version}.rpm\"" do
  not_if 'rpm -qa | grep kernel-devel'
  not_if 'ls | grep kernel-devel'
end

execute "rpm -ivh #{kernel_devel_expected_version}.rpm" do
  not_if 'rpm -qa | grep kernel-devel'
end
