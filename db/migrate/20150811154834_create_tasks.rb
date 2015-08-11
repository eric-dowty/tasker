class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :list, index: true, foreign_key: true
      t.string :title
      t.string :status, default: "incomplete"
      t.string :notes
      t.datetime :due_date
      t.datetime :start_date
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
