# typed: false

require 'rails_helper'

RSpec.describe "user_accounts/new" do
  before do
    assign(:user_account, UserAccount.new())
  end

  it "renders new user_account form" do
    render

    assert_select "form[action=?][method=?]", user_accounts_path, "post" do
    end
  end
end
