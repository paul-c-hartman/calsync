class AddSyncFieldsToCalendars < ActiveRecord::Migration[8.1]
  def change
    add_column :calendars, :sync_cursor, :string
    add_column :calendars, :last_synced_at, :datetime
    add_column :calendars, :feed_url, :string
  end
end
