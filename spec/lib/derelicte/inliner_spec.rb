require 'spec_helper'

describe Derelicte::Inliner do
  let(:css) { "p { color: #ff0000; }" }
  let(:html) { "<div><p>ohai</p></div>" }

  subject { described_class.new }
  it "should apply css rules to html elements" do
    inlined_html = subject.inline(html, css)
    expect(inlined_html).to include('<div><p style="color: #ff0000;">ohai</p></div>')
  end

  it "should keep doctypes intact" do
    html = file_contents('simple_dom.html')
    inlined_html = subject.inline(html, "")
    expect(inlined_html).to eq(html.chomp)
  end
end
