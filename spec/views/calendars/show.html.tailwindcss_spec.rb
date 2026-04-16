# typed: false

require 'rails_helper'

RSpec.describe "calendars/show" do
  let (:calendar) {
    create_calendar!
  }

  before do
    assign(:calendar, calendar)
  end

  it "renders attributes in <p>" do
    render
  end
end
