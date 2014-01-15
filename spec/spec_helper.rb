require 'bundler/setup'
require 'rspec'
require 'better_receive'
require 'java_css_inliner'

RSpec.configure do |c|
  c.color = true
  c.order = :rand
end
