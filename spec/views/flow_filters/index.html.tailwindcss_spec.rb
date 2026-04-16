# typed: false

require 'rails_helper'

RSpec.describe "flow_filters/index" do
  let (:flow_filters) {
    create_flow_filter!(count: 2)
  }

  before do
    assign(:flow_filters, flow_filters)
  end

  it "renders a list of flow_filters" do
    render
    cell_selector = 'div>p'
  end
end
