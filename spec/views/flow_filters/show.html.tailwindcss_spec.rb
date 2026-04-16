# typed: false

require 'rails_helper'

RSpec.describe "flow_filters/show" do
  let (:flow_filter) {
    create_flow_filter!
  }

  before do
    assign(:flow_filter, flow_filter)
  end

  it "renders attributes in <p>" do
    render
  end
end
