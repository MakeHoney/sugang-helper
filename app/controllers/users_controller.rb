class UsersController < Devise::RegistrationsController

  def edit
    loadList()
  end

end
