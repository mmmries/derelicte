require 'bundler/setup'
require 'rspec'
require 'better_receive'
require 'derelicte'

RSpec.configure do |c|
  c.color = true
  c.order = :rand
end

def file_contents(basename)
  path = File.join( File.dirname(__FILE__), 'files', basename )
  File.read(path)
end

def doc_style(doc, tag_name)
  doc.get_elements_by_tag_name(tag_name).item(0).get_attribute('style')
end
