# OpenConfig
It allows you to build OpenStruct trees from your configuration files

## Installation
Install OpenConfig on your machine as any other Ruby gem

```sh
$ gem install open_config
```

## Usage
Imagine, you have file, called `configuration.yml` in your project's config folder:

```yaml
development:
  key: value
  another_key: 123
production:
  key: production_value
  another_key: 321
```
You can create OpenConfig instance `open_config = OpenConfig::YAML.new(root: 'config', file: 'configuration.yml')`, and access configuration keys on any depth by simple method calls:

```ruby
pry(main)> open_config.production.another_key
=> 321
```

Same thing will work with `configuration.json`, just use `OpenConfig::JSON` instead
