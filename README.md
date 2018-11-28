# Test Session Manager

Have you ever wanted to inject session information into a request in your Rails tests? Sure, best practices recommend you do so by first making a request to a resource that sets the desired session information for you, but sometimes...well, sometimes you just want a shortcut.

That's what the Test Session Manager gem does for you: lets your tests specify the contents of the session explicitly before making a request.


## Installation, Configuration, and Usage

Add the "test_session_manager" gem to your Gemfile:

```ruby
group :test do
  gem 'test_session_manager'
end
```

Add the Test Session Manager middleware to `config/application.rb`:

```ruby
if Rails.env.test?
  # initialize the manager that your tests will use
  manager = TestSessionManager.new

  # set it in your application's config, so your tests can find it
  config.test_session_manager = manager

  # install the middleware
  config.middleware.use TestSessionManager::Middleware, manager
end
```

Add a minimal helper to your tests:

```ruby
class ActiveSupport::TestCase
  # ...

  def next_request
    Rails.application.config.test_session_manager
  end
end
```

Then, use the `next_request` helper to set session and flash values in your tests!

```ruby
  test 'show that session and flash can be set in tests' do
    next_request.flash[:error] = "Something died!"
    next_request.session[:favorite_color] = "green"

    get '/path/to/test'
    assert_select '.alert-error', 'Something died!'
    assert_select '.favorite-color', 'green'
  end
```

## License

Test Session Manager is released under the MIT license (see MIT-LICENSE) by
Jamis Buck (jamis@jamisbuck.org).
