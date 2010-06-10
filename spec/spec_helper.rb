$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'openxml4ruby'
require 'spec'
require 'spec/autorun'
require "nokogiri"

Spec::Runner.configure do |config|
end

def noko(xml_string = nil)
  unless xml_string
    xml_string = ""
    xml = Builder::XmlMarkup.new(:target=> xml_string)
    yield xml if block_given?
  end
  Nokogiri::XML(xml_string)
end

class HaveAttributes
  def initialize(attr)
    @attr = attr
  end
  def matches?(tag)
    @tag = tag
    return false unless @tag.attributes.length == @attr.length

    @attr.each do |name, value|
      if @tag.attributes.has_key?(name)
        unless @tag.attributes[name].value == value
          return false
        end
      else
        return false 
      end
    end

    true
  end
  def failure_message_for_should
    "tag #{@tag.name} should have #{@attr.length} attributes: #{@attr.inspect} GOT: #{@tag.attributes.inspect}"
  end
  def failure_message_for_should_not
    "tag #{@tag.name} should NOT have #{@attr.length} attributes: #{@attr.inspect} GOT: #{@tag.attributes.inspect}"
  end
end

def have_attributes(expected)
  HaveAttributes.new(expected)
end
