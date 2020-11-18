class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.uuid :user_id
      t.string :title
      t.text :description
      t.datetime :due_date
      t.boolean :done, default: false
      t.integer :order_index

      t.timestamps
    end
  end
end
