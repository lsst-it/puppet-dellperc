source ENV['GEM_SOURCE'] || 'https://rubygems.org'

ruby_version_segments = Gem::Version.new(RUBY_VERSION.dup).segments
minor_version = ruby_version_segments[0..1].join('.')

group :test do
  gem "puppet-module-posix-dev-r#{minor_version}", '~> 1.0', require: false, platforms: [:ruby]
  gem 'rubocop', '~> 1.6.1',                                 require: false
  gem 'rubocop-i18n', '~> 3.0.0',                            require: false
end

group :system_tests do
  gem "puppet-module-posix-system-r#{minor_version}", '~> 1.0', require: false, platforms: [:ruby]
  gem 'voxpupuli-acceptance',                                   require: false
end

gem 'puppetlabs_spec_helper', '~> 2.0', require: false
gem 'puppet_metadata', '~> 0.4.0',      require: false

puppet_version = ENV['PUPPET_GEM_VERSION'] || '~> 6.0'
facter_version = ENV['FACTER_GEM_VERSION']
hiera_version = ENV['HIERA_GEM_VERSION']

gem 'facter', facter_version, require: false, groups: [:test]
gem 'hiera', hiera_version,   require: false, groups: [:test]
gem 'puppet', puppet_version, require: false, groups: [:test]

# vim: syntax=ruby
