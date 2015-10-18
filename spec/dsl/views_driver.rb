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
            navigate_to_people
            find('.views').click_link '+'
            fill_in 'view_name', with: viewName
            params[:fields].each do |fieldName|
                check fieldName
            end
            click_button 'Save'
        end

        def has_views(*viewAliases)
            view_names = viewAliases.map { |viewAlias| @views.get viewAlias }

            navigate_to_people
            actual_links = page.all('.views a').map { |el| el.text }
            expect(actual_links).to eq (view_names + [ '+' ])
        end

        def edit(viewAlias, options = {})
            params = parse_params(options, {
                select: [],
                unselect: []
            })

            edit_view viewAlias
            params[:select].each do |fieldName|
                check fieldName
            end
            params[:unselect].each do |fieldName|
                check fieldName
            end
            click_button 'Save'
        end

        def delete(viewAlias)
            edit_view viewAlias
            click_link 'Delete View'
        end

        private
        def navigate_to_people
            find('.navbar').click_link 'People'
        end

        def edit_view viewAlias
            viewName = @views.get viewAlias

            navigate_to_people
            find('.views').click_link viewName
            click_link 'Edit View'
        end
    end
end
