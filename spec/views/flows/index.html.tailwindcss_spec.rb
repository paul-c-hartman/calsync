# typed: false

require 'rails_helper'

RSpec.describe "flows/index" do
  let (:flows) {
    create_flow!(count: 2)
  }

  before do
    assign(:flows, flows)
  end

  it "renders a list of flows" do
    render
    cell_selector = 'div>p'
  end
end
