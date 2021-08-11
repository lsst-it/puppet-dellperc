# frozen_string_literal: true

require 'bundler'
require 'puppet_litmus/rake_tasks' if Bundler.rubygems.find_name('puppet_litmus').any?
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet_blacksmith/rake_tasks' if Bundler.rubygems.find_name('puppet-blacksmith').any?
require 'github_changelog_generator/task' if Bundler.rubygems.find_name('github_changelog_generator').any?
require 'puppet-strings/tasks' if Bundler.rubygems.find_name('puppet-strings').any?

PuppetLint.configuration.send('disable_relative')

task default: %w[
  check:symlinks
  check:git_ignore
  check:dot_underscore
  check:test_file
  rubocop
  syntax
  lint
  metadata_lint
  spec
]
