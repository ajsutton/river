# -*- encoding : utf-8 -*-
class ViewsController < ApplicationController
    before_action :require_church!

    def new
        @view = View.new church: current_user.church, applies_to: params[:applies_to]
        @fields = custom_fields params[:applies_to]
        render 'new', layout: params[:applies_to].pluralize
    end

    def create
        Rails.logger.info params[:fields]
        @view = View.new view_params
        @view.church = current_user.church
        @view.applies_to = params[:applies_to]
        if @view.save
            redirect_to people_path
        else
            @fields = custom_fields params[:applies_to]
            render "new"
        end
    end

    private

    def custom_fields(applies_to)
        schema = FieldSchema.find_by({ church: current_user.church, applies_to: applies_to })
        schema.nil? ? [] : schema.fields
    end

    def view_params
        params.require(:view).permit(:name, :fields => [])
    end
end
