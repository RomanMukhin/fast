class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :consumer_id
      t.integer :doer_id
      t.string :state
      t.timestamps
    end
  end
end
