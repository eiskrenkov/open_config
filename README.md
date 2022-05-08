[![Gem Version](https://badge.fury.io/rb/open_config.svg)](https://badge.fury.io/rb/open_config)
[![Build](https://github.com/eiskrenkov/open_config/actions/workflows/rspec.yml/badge.svg)](https://github.com/eiskrenkov/open_config/actions/workflows/rspec.yml)

# OpenConfig
Ruby gem, that allows you to build deep OpenStructs from your YAML or JSON configuration files

## Installation
Add `open_config` to the project's `Gemfile`:

```ruby
gem 'open_config', '~> 2.0'
```

or as a dependency in your gem's `.gemspec` file

```ruby
Gem::Specification.new do |spec|
  # ...
  spec.add_dependency 'open_config', '~> 2.0'
  # ...
end
```

### Supported Ruby versions
- **MRI** >= 2.4
- **JRuby** >= 9.2

## Usage
Imagine, you have file, called `configuration.yml` in your project's config folder:

```yaml
ruby: <%= 2 + 2 * 2 %>
node:
  string: Some String
  integer: 123
  float: 1.23
  boolean: false
  nested_node:
    array:
      - First Element
      - Second Element
```

You can create OpenConfig instance, and access configuration keys using all advantages of Ruby's `OpenStruct`

```ruby
> config = OpenConfig::YAML.new('configuration.yml')
=> #<OpenConfig::Node
  ruby: 6,
  node: #<OpenConfig::Node
    string: "Some String",
    integer: 123,
    float: 1.23,
    boolean: false,
    nested_node: #<OpenConfig::Node array: ["First Element", "Second Element"]>>>

> config.ruby
=> 6

> config.node
=> #<OpenConfig::Node
  string: "Some String",
  integer: 123,
  float: 1.23,
  boolean: false,
  nested_node: #<OpenConfig::Node array: ["First Element", "Second Element"]>>

> config.node['string']
=> "Some String"

> config.node[:boolean]
=> false

> config.dig(:node, :string)
=> "Some String"

> config.fetch(:foobar, 123)
=> 123

> config.fetch(:foobar) # => Exception in `fetch': key not found: :foobar (KeyError)
> config.foobar # => Exception in `method_missing': undefined method `foobar' for #<OpenConfig::Node>
```

Same thing will work with `configuration.json`, just use `OpenConfig::JSON` instead

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/eiskrenkov/open_config](https://github.com/eiskrenkov/open_config)

## License

OpenConfig is released under [MIT License](http://opensource.org/licenses/MIT)
