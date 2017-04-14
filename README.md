# Bako
[![Gem Version](https://badge.fury.io/rb/bako.svg)](https://badge.fury.io/rb/bako)
[![Code Climate](https://codeclimate.com/github/ayemos/bako/badges/gpa.svg)](https://codeclimate.com/github/ayemos/bako)
[![Test Coverage](https://codeclimate.com/github/ayemos/bako/badges/coverage.svg)](https://codeclimate.com/github/ayemos/bako/coverage)
[![Issue Count](https://codeclimate.com/github/ayemos/bako/badges/issue_count.svg)](https://codeclimate.com/github/ayemos/bako)

Bako is a CLI tool to manage your [AWS Batch](https://aws.amazon.com/batch/) jobs. It also has its own DSL for AWS Batch.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bako'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bako

## Usage

### Prepare environment

Before start using Bako, you need to prepare basic environment on AWS Batch.
We need at least
- one Job Queue
- one Compute Environment
- and one [Amazon EC2 Container Registory](https://aws.amazon.com/jp/ecr/) (only if you use container image for batch implementation)

## Examples

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bako.

