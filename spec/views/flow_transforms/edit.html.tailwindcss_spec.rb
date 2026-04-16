# typed: false

require 'rails_helper'

RSpec.describe "flow_transforms/edit" do
  let(:flow_transform) {
    create_flow_transform!
  }

  before do
    assign(:flow_transform, flow_transform)
  end

  it "renders the edit flow_transform form" do
    render

    assert_select "form[action=?][method=?]", flow_transform_path(flow_transform), "post" do
    end
  end
end
