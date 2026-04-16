# typed: false

require 'rails_helper'

RSpec.describe "calendars/edit" do
  let(:calendar) {
    create_calendar!
  }

  before do
    assign(:calendar, calendar)
  end

  it "renders the edit calendar form" do
    render

    assert_select "form[action=?][method=?]", calendar_path(calendar), "post" do
    end
  end
end
