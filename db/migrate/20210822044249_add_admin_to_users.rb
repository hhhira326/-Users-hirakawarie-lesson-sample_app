class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    #default: false はデフォルトでは管理者になれないということを示す。admin(管理者)
  end
end
