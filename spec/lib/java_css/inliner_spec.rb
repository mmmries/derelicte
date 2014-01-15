require 'spec_helper'

describe JavaCSS::Inliner do
  let(:css) { "p { color: red; }" }
  let(:html) { "<div><p>ohai</p></div>" }

  subject { described_class.new }
  it "should apply css rules do html elements" do
    inlined_html = subject.inline(html, css)
    expect(inlined_html).to eql('<div><p style="color:red;">ohai</p></div>')
  end
end
