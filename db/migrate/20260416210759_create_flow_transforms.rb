class CreateFlowTransforms < ActiveRecord::Migration[8.1]
  def change
    create_table :flow_transforms do |t|
      t.string :field_name, null: false
      t.integer :action, null: false, default: 0
      t.integer :position, null: false
      t.json :value_json
      t.references :flow, null: false, foreign_key: true

      t.timestamps
    end

    add_index :flow_transforms, [:flow_id, :position], unique: true
  end
end
