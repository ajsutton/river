module ApplicationHelper
  def bootstrap_class_for flash_type
    logger.info("Flash type: " + flash_type)
    { "success" => "alert-success", "error" => "alert-danger", "alert" => "alert-warning", "notice" => "alert-info" }[flash_type] || flash_type.to_s
  end
    
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
  
  def render_errors(model)
    if model.errors.any?
      concat(content_tag(:div, '', class: 'alert alert-danger fade in') do
        model.errors.full_messages.each do |msg|
          concat content_tag(:p, msg)
        end
      end)
    end
    nil
  end
end