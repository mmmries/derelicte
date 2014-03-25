require 'spec_helper'

describe Derelicte::Inliner do
  let(:html) { file_contents('simple_dom.html') }
  let(:css) { file_contents('basic.css') }

  subject { described_class.new }
  it "should apply css rules to html elements" do
    inlined_html = subject.inline(html, css)
    expect(inlined_html).to include('<p style="color: #ff0000;">ohai</p>')
    expect(inlined_html).to start_with('<!DOCTYPE html>')
  end

  it "should return valid html" do
    inlined_html = subject.inline(html, css)
    expect {
      Derelicte.doc_from_str(inlined_html)
    }.to_not raise_error
  end

  context "xhtml doctype" do
    let(:html) { file_contents('xhtml_dom.html') }

    it "should change the doctype to html 5 standard" do
      inlined_html = subject.inline(html, css)
      expect(inlined_html).to start_with("<!DOCTYPE html>")
    end
  end

  context "existing inline styles" do
    let(:html) { file_contents('inline_style_dom.html') }

    it "should append to existing inline styles" do
      inlined_html = subject.inline(html, css)
      expect(inlined_html).to include('<p style="color: #ff0000;">ohai</p>')
      expect(inlined_html).to include('<p style="color: #ff0000;font-size: 18pt;">ohai</p>')
    end
  end
end
