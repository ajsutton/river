modulejs.define('view', function() {
    $(document).on("page:change", function() {
        $('div[data-filters]').each(function() {
            var element = $('#' + $(this).attr('id'));
            var fields = JSON.parse(element.attr('data-filters'));
            var filters = filtersForFields(fields);
            filters.unshift(textField('First Name', 'first_name'));
            filters.unshift(textField('Last Name', 'last_name'));
            element.jui_filter_rules({
                bootstrap_version: '3',
                filters: filters,
                onValidationError: onValidationError
            })
            var formField = $('#view_filters');

            element.closest('form').submit(function(e) {
                var rules = [];
                element.jui_filter_rules('getRules', 0, rules);
                formField.val(JSON.stringify(rules));
            });
        });
    });

    function onValidationError(event, data) {
        alert(data["err_description"] + ' (' + data["err_code"] + ')');
        data.elem_filter.focus();
    }

    function filtersForFields(fields) {
        var filters = [];
        $.each(fields, function(idx, field) { filters.push(filterForField(field)) });
        console.log(filters);
        return filters;
    }

    function filterForField(field) {
        switch (field.type) {
            case 'boolean':
                return booleanField(field.name, field.id);
            default:
                return textField(field.name, field.id);
        }
    }

    function textField(name, id) {
        return {
            filterName: id,
            filterType: 'text',
            field: id,
            filterLabel: name,
            excluded_operators: ['in', 'not_in', 'is_null', 'is_not_null']
        }
    }

    function booleanField(name, id) {
        return {
            filterName: id,
            filterType: "text",
            field: id,
            filterLabel: name,
            excluded_operators: [
                "in", "not_in", "less", "less_or_equal", "greater", "greater_or_equal", 'is_null', 'is_not_null',
                'is_empty', 'is_not_empty', 'not_equal', 'begins_with', 'not_begins_with', 'contains', 'not_contains',
                'ends_with', 'not_ends_with'],
            filter_interface: [
                {
                    filter_element: "input",
                    filter_element_attributes: {
                        type: "radio"
                        // style: "width: auto; margin-top: 0; display: inline-block;"
                    }
                }
            ],
            lookup_values: [
                {lk_option: "True", lk_value: "true", lk_selected: 'yes'},
                {lk_option: "False", lk_value: "false"}
            ]
        }
    }
});
