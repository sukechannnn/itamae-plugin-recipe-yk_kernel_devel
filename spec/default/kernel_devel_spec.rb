require 'spec_helper'

describe package('wget') do
  it { should be_installed }
end

describe package('kernel-devel') do
  it { should be_installed }
end

kernel_version = command('uname -r').stdout

describe package('kernel-devel') do
  it { should be_installed.with_version("#{kernel_version}") }
end
