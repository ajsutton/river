# -*- encoding : utf-8 -*-
module PeopleHelper
    def active_view?(view)
        Rails.logger.info view.id
        !@current_view.nil? && @current_view.id == view.id
    end
end
