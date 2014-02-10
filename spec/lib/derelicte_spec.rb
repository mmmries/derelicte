require 'spec_helper'

describe ::Derelicte do
  subject { ::Derelicte }
  let(:html) { 'html' }
  let(:css) { 'css' }
  let(:inlined) { 'inlined' }
  let(:inliner) { ::Derelicte::Inliner.new }

  it "has a convenience method for doing inlining" do
    inliner.better_receive(:inline)
      .with(html, css).and_return(inlined)

    ::Derelicte::Inliner.better_receive(:new)
      .with().and_return( inliner )

    expect(subject.inline(html, css)).to eq(inlined)
  end
end
