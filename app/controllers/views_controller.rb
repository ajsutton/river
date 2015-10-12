# -*- encoding : utf-8 -*-
class ViewsController < ApplicationController
    before_action :require_church!

    def new
        @view = View.new church: current_user.church, applies_to: params[:applies_to]
        @fields = custom_fields params[:applies_to]
        render 'new'
    end

    def show
        @view = View.find(params[:id])
        @fields = custom_fields params[:applies_to]
    end

    def create
        @view = View.new view_params
        @view.church = current_user.church
        @view.applies_to = params[:applies_to]
        if (@view.filters.is_a? String)
            @view.filters = nil
        end

        if @view.save
            redirect_to people_path(view: @view.id)
        else
            @fields = custom_fields params[:applies_to]
            render "new"
        end
    end

    def update
        @view = View.find(params[:id])

        if !@view then
          not_found
        else
          if @view.update(view_params)
            people_path(view: @view.id)
          else
            @fields = custom_fields params[:applies_to]
            render 'show'
          end
        end
    end

    private

    def custom_fields(applies_to)
        schema = FieldSchema.find_by({ church: current_user.church, applies_to: applies_to })
        schema.nil? ? [] : schema.fields
    end

    def view_params
        params.require(:view).permit(:name, :filters, :fields => [])
    end
end
