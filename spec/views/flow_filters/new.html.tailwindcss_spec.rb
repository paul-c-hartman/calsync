# typed: false

require 'rails_helper'

RSpec.describe "flow_filters/new" do
  before do
    assign(:flow_filter, FlowFilter.new())
  end

  it "renders new flow_filter form" do
    render

    assert_select "form[action=?][method=?]", flow_filters_path, "post" do
    end
  end
end
