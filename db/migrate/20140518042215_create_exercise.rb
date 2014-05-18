class CreateExercise < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.string :type
      t.integer :duration
      t.timestamps
    end
  end

  def self.down
  end
end
