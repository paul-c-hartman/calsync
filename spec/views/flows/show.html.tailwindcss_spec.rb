# typed: false

require 'rails_helper'

RSpec.describe "flows/show" do
  let (:flow) {
    create_flow!
  }

  before do
    assign(:flow, flow)
  end

  it "renders attributes in <p>" do
    render
  end
end
