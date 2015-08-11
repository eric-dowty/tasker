require 'rails_helper'
RSpec.describe "an example test" do
  it "passes this test" do
    expect(true).to eq(true)
  end
  it "fails this test" do
    expect(true).to eq(false)
  end
  xit "this test is pending" do
  end
end