class ChurchesController < ApplicationController
  def new
    @church = Church.new
  end
  
  def create
    @church = Church.new(church_params)
    self.current_user.church = @church
    if @church.valid? && current_user.valid? && @church.save && current_user.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  
  private
    def church_params
      params.require(:church).permit(:name, :shortname)
    end
end
