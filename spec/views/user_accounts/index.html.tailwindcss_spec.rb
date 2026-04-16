# typed: false

require 'rails_helper'

RSpec.describe "user_accounts/index" do
  let (:user_accounts) {
    create_user_account!(count: 2)
  }

  before do
    assign(:user_accounts, user_accounts)
  end

  it "renders a list of user_accounts" do
    render
    cell_selector = 'div>p'
  end
end
