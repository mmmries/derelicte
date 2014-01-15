require "java_css_inliner/version"

# Load jars
require 'jars/antlr-runtime-3.1.jar'
require 'jars/slf4j-api-1.5.2.jar'
require 'jars/slf4j-nop-1.5.2.jar'
require 'jars/xml-apis-1.3.04.jar'
require 'jars/jstyleparser-1.7.0.jar'

# Load local classes
require 'css/inliner'
require 'css/inliner_job'

module JavaCSSInliner
  DOCTYPE = "<!DOCTYPE html>"

  def self.css_analyzer_from_str(str)
    stylesheet = Java::CzVutbrWebCss::CSSFactory.parse(str)
    Java::CzVutbrWebDomassign::Analyzer.new(stylesheet)
  end

  def self.doc_from_str(str)
    reader = java.io.StringReader.new(str.to_java_string)
    source = Java::OrgXmlSax::InputSource.new(reader)
    fac = Java::JavaxXmlParsers::DocumentBuilderFactory.newInstance()
    fac.set_namespace_aware(false)
    builder = fac.new_document_builder
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
