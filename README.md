[![Gem Version](https://badge.fury.io/rb/itamae-plugin-recipe-yk_kernel_devel.svg)](https://badge.fury.io/rb/itamae-plugin-recipe-yk_kernel_devel)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/yosuke0315/itamae-plugin-recipe-yk_kernel_devel/blob/master/LICENSE.txt)

# Itamae::Plugin::Recipe::YkKernelDevel

Itamae plugin to install kernel-devel.<br>
This plugin can install the same version of the kernel-devel with your kernel.<br>
This is available only on redhat.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-yk_kernel_devel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-yk_kernel_devel

## Usage

### install for system

```rb
include_recipe "yk_kernel_devel::install"
```

## License

[MIT License](http://opensource.org/licenses/MIT).
