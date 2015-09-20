class ChurchesController < ApplicationController
  def new
    @church = Church.new
  end
  
  def create
    @church = Church.new(church_params)
    if @church.save
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
