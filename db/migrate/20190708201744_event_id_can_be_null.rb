class EventIdCanBeNull < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :event_id, :integer, null: true
  end
end
