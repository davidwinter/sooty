# Sooty

Install Puppet via Rake and apply your manifests.

## Installation

Add this line to your application's Gemfile:

    gem 'sooty'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sooty

## Usage

Sooty allows you to easily setup Puppet on your server, and apply your manifests
to it.

A simple example for your `Rakefile` would be:

	require "rubygems"
	require "bundler/setup"

	require 'sooty'

	set :domain, 'user@server.com'

	set :puppet_manifest, 'private/puppet/manifest.pp'
	set :puppet_modules, 'private/puppet/modules'

You'd then the following once to get Puppet installed:

	rake sooty:setup

Then whenever you make changes to your Puppet manifests, just run:

	rake sooty:apply

This will apply those changes on the server for you and ensure everything is
up-to-date.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
