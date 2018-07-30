module ApplicationHelper
  def flash_toastr
  flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "toastr.#{type}('#{message}','',{ 'closeButton': true });"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
