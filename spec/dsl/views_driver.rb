# -*- encoding : utf-8 -*-
module DslUtil
    class ViewsDriver
        include Capybara::DSL
        include ::RSpec::Matchers
        include DslUtil

        def initialize(views)
            @views = views
        end

        def create(viewAlias, options = {})
            params = parse_params(options, {
                fields: []
            })

            viewName = @views.get_or_create viewAlias do |name|
                name
            end
            find('.navbar').click_link 'People'
            find('.views').click_link '+'
            fill_in 'view_name', with: viewName
            params[:fields].each do |fieldName|
                check fieldName
            end
        end
    end
end
