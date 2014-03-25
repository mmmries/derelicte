require 'spec_helper'
require 'pry'

describe ::Derelicte::InlinerJob do
  let(:doc) { ::Derelicte.doc_from_str('<p class="red">ohai</p>') }
  let(:analyzer) { ::Derelicte.css_analyzer_from_str('p { color: #ffffff; } .red { color: #ff0000; }') }

  subject { described_class.new(doc, analyzer) }

  it "does not duplicate style rules" do
    subject.apply_rules_to_doc
    expect(doc_style(doc, 'p')).to eq('color: #ff0000;')
  end
end
