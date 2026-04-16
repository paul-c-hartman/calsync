# typed: false

require 'rails_helper'

RSpec.describe "users/index" do
  let (:users) {
    create_user!(count: 2)
  }

  before do
    assign(:users, users)
  end

  it "renders a list of users" do
    render
    cell_selector = 'div>p'
  end
end
