# typed: false

require 'rails_helper'

RSpec.describe "flow_transforms/index" do
  let (:flow_transforms) {
    create_flow_transform!(count: 2)
  }

  before do
    assign(:flow_transforms, flow_transforms)
  end

  it "renders a list of flow_transforms" do
    render
    cell_selector = 'div>p'
  end
end
