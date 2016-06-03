# Calapog

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'calapog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calapog

## Usage

`calapog generate SharedClassPage` will generate the following scaffold(replace Class with the name of your page):

* `features/pages/shared_class_name.rb` with the following code: 

```ruby
class SharedClassPage < CommonPage

  def trait

  end

  def page_data_file
    'class_page'
  end

  private
end
```

* `features/android/pages/class_name.rb` with the following code:

```ruby
class Android::ClassPage < SharedClassPage
  include Calabash::Android

  private
end
```

* `features/ios/pages/class_name.rb` with the following code:

```ruby
class IOS::ClassPage < SharedClassPage
  include Calabash::IOS

  private
end
```

## Contributing

Bug reports and pull requests are welcome on GitLab at https://gitlab.com/distortia/calapog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

