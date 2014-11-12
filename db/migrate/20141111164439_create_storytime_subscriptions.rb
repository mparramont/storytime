class CreateStorytimeSubscriptions < ActiveRecord::Migration
  def change
    create_table :storytime_subscriptions do |t|
      t.string :email
      t.boolean :subscribed, default: true

      t.timestamps
    end
  end
end