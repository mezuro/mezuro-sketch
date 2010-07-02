# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def formated unformated_date
    return unformated_date.to_date.gregorian.inspect.gsub /.*,\s*/, ""
  end

end
