#LT Analytics

LTAnalytics is an extension for Split gem. LTAnalytics makes possible to push
Split data into Google Analytics.


#Installation
```ruby
gem 'lt-analytics', :git => 'git://github.com/nicholasrq/lt-analytics.git'
```

#Usage

In your view include this:

```erb
<% tracking_code(:account => "UA-123456-78") %>
```

#Advanced usage
As well as `:account` you can specify some other options:

```erb
<% tracking_code({
	:account => "UA-123456-78",
	:rails_env => :production,		// helper will render content only in production
	:partial => "index/analytics"	// use the partial instead of raw code from gem
}) %>
```

Also `rails_env` can be a string or array of strings or array of symbols.

In the partial you'll have some local variables:

* `account` – your account code
* `custom_vars`	– data from Split

Helper has the second parameter: `top`, true by default.
This parameter enables skipping `account` option if you use async type of GA installation.
Unless `top` is false exception will be raised if you didn't specify `account` option.
