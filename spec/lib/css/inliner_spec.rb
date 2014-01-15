require 'spec_helper'

describe CSS::Inliner do
  let(:css) { "p { color: #ff0000; }" }
  let(:html) { "<div><p>ohai</p></div>" }

  subject { described_class.new }
  it "should apply css rules do html elements" do
    inlined_html = subject.inline(html, css)
    expect(inlined_html).to include('<div><p style="color: #ff0000;">ohai</p></div>')
  end
end
