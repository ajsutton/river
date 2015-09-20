class ChurchesController < ApplicationController
  def new
    @church = Church.new
    @user = User.new
    @user.church = @church
  end
  
  def create
    @church = Church.new(church_params)
    @user = User.new(params.require(:user).permit(:username, :password))
    @user.church = @church
    if @church.valid? && @user.valid? && @church.save && @user.save
      redirect_to churches_path
    else
      render 'new'
    end
  end
  
  
  private
    def church_params
      params.require(:church).permit(:name, :shortname)
    end
end
