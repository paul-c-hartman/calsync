class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :time_zone, default: "UTC"
      t.boolean :all_day, default: false
      t.boolean :busy, default: true
      t.string :provider_id, null: false
      t.references :calendar, null: false, foreign_key: true

      t.check_constraint "starts_at < ends_at", name: "check_starts_at_before_ends_at"
      
      t.timestamps
    end
    add_index :events, [:calendar_id, :provider_id], unique: true
    add_index :events, [:calendar_id, :starts_at], unique: true
  end
end
