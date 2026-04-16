# typed: false

require 'rails_helper'

RSpec.describe "flow_transforms/new" do
  before do
    assign(:flow_transform, FlowTransform.new())
  end

  it "renders new flow_transform form" do
    render

    assert_select "form[action=?][method=?]", flow_transforms_path, "post" do
    end
  end
end
