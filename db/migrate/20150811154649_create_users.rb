class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :image_url
      t.string :token
      t.string :provider
      t.string :uid
      t.timestamps
    end
  end
end
