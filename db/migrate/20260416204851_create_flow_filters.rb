class CreateFlowFilters < ActiveRecord::Migration[8.1]
  def change
    create_table :flow_filters do |t|
      t.string :field_name, null: false
      t.integer :operator, null: false
      t.json :value_json
      t.references :flow, null: false, foreign_key: true

      t.timestamps
    end
  end
end
