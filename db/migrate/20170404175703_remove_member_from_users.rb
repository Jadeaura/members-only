class RemoveMemberFromUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.remove :member
    end
  end
end
