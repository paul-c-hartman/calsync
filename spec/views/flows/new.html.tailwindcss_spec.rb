# typed: false

require 'rails_helper'

RSpec.describe "flows/new" do
  before do
    assign(:flow, Flow.new())
  end

  it "renders new flow form" do
    render

    assert_select "form[action=?][method=?]", flows_path, "post" do
    end
  end
end
