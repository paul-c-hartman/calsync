# typed: false

require 'rails_helper'

RSpec.describe "flow_filters/edit" do
  let(:flow_filter) {
    create_flow_filter!
  }

  before do
    assign(:flow_filter, flow_filter)
  end

  it "renders the edit flow_filter form" do
    render

    assert_select "form[action=?][method=?]", flow_filter_path(flow_filter), "post" do
    end
  end
end
