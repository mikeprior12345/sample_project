class UpdateUsers1 < ActiveRecord::Migration[6.1]
  def change
  @u = User.find_by( email: 'mike.prior@optum.com' )
  @u.update_attribute :admin, true
  end
end
