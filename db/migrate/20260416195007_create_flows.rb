class CreateFlows < ActiveRecord::Migration[8.1]
  def change
    create_table :flows do |t|
      t.references :source_calendar, null: false, foreign_key: { to_table: :calendars }
      t.references :destination_calendar, null: false, foreign_key: { to_table: :calendars }
      # Check constraints to ensure source and destination calendars are not the same
      t.string :label
      t.references :user, null: false, foreign_key: true

      t.check_constraint 'source_calendar_id <> destination_calendar_id', name: 'flows_source_destination_different'

      t.timestamps
    end
    
    add_index :flows, [:source_calendar_id, :destination_calendar_id], unique: true
  end
end
