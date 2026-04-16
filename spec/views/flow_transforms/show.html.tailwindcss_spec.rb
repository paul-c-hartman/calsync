# typed: false

require 'rails_helper'

RSpec.describe "flow_transforms/show" do
  let (:flow_transform) {
    create_flow_transform!
  }

  before do
    assign(:flow_transform, flow_transform)
  end

  it "renders attributes in <p>" do
    render
  end
end
