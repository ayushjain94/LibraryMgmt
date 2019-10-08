class CreateOmniauthCallbacksControllers < ActiveRecord::Migration[6.0]
  def change
    create_table :omniauth_callbacks_controllers do |t|

      t.timestamps
    end
  end
end
