require "derelicte/version"

# Load jars
unless defined?(::Java::OrgAntlrRuntime::Parser)
  require 'jars/antlr-runtime-3.1.jar'
end
unless defined?(org.slf4j.Logger)
  require 'jars/slf4j-api-1.5.2.jar'
  require 'jars/slf4j-nop-1.5.2.jar'
end
require 'jars/xml-apis-1.3.04.jar'
unless defined?(::Java.cz.vutbr.web.css::CSSFactory)
  require 'jars/jstyleparser-1.7.0.jar'
end
unless defined?(Java::NuValidatorHtmlparserDom::HtmlDocumentBuilder)
  require 'jars/htmlparser-1.4'
end

# Load local classes
require 'derelicte/inliner'
require 'derelicte/inliner_job'

module Derelicte
  DOCTYPE = "<!DOCTYPE html>"

  def self.css_analyzer_from_str(str)
    stylesheet = Java::CzVutbrWebCss::CSSFactory.parse(str)
    Java::CzVutbrWebDomassign::Analyzer.new(stylesheet)
  end

  def self.doc_from_str(str)
    reader = java.io.StringReader.new(str.to_java_string)
    source = Java::OrgXmlSax::InputSource.new(reader)
    builder = Java.nu.validator.htmlparser.dom.HtmlDocumentBuilder.new
    builder.parse(source)
  end

  def self.doc_to_str(doc)
    serializer = doc.get_implementation
                    .get_feature('LS','3.0')
                    .create_ls_serializer
    serializer.get_dom_config.set_parameter('xml-declaration', false)
    doc_str = serializer.write_to_string(doc)
    DOCTYPE + "\n" + doc_str
  end
end
