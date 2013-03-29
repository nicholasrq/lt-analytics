# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lt-analytics-version"

Gem::Specification.new do |s|
	s.name        = 'lt-analytics'
	s.version     = Split::LTAnalytics::VERSION
	s.date        = '2012-03-29'
	s.summary     = "Hola!"
	s.description = "Google Analytics extension for Split"
	s.authors     = ["Nikita Skryabin"]
	s.email       = 'ns@level.travel'
	s.files       = ["lib/lt-analytics.rb"]
	s.homepage    = 'http://github.com/nicholasrq/split-analytics-lt'
end