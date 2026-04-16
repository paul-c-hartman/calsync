# typed: false

require 'rails_helper'

RSpec.describe "calendars/index" do
  let (:calendars) {
    create_calendar!(count: 2)
  }

  before do
    assign(:calendars, calendars)
  end

  it "renders a list of calendars" do
    render
    cell_selector = 'div>p'
  end
end
