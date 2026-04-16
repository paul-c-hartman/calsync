class CreateUserAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :user_accounts do |t|
      t.string :email, null: false
      t.string :provider, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
