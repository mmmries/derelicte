require 'spec_helper'

describe ::Derelicte do
  subject { ::Derelicte }
  let(:html) { 'html' }
  let(:css) { 'css' }
  let(:inlined) { 'inlined' }
  let(:inliner) { ::Derelicte::Inliner.new }

  it "has a convenience method for doing inlining" do
    expect(::Derelicte::Inliner).to receive(:new).with(no_args).and_return( inliner )
    expect(inliner).to receive(:inline).with(html, css).and_return(inlined)

    expect(subject.inline(html, css)).to eq(inlined)
  end
end
