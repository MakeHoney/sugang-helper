class UsersController < Devise::RegistrationsController

  def edit
    loadList()
  end
  
  def update
    loadList()
  end

end
