# typed: false

require 'rails_helper'

RSpec.describe "flows/edit" do
  let(:flow) {
    create_flow!
  }

  before do
    assign(:flow, flow)
  end

  it "renders the edit flow form" do
    render

    assert_select "form[action=?][method=?]", flow_path(flow), "post" do
    end
  end
end
