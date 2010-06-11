# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 def module_metrics_names
    [:acc, :accm, :amloc, :anpm, :cbo, :dit, :lcom4, :mmloc, :noc, :nom, :npm, :npv, :rfc, :tloc]
  end

  def statistical_value
    [:kurtosis, :maximum, :median, :minimum, :mode, :skewness, :standard_deviation, :sum, :variance]
  end
  
  def value_of preffix, suffix, metric_list
    searched = preffix.to_s + '_' + suffix.to_s
    value = ""
    metric_list.each do |metric|
      value = metric.value if metric.name == searched
    end
    return value
  end

  def formated unformated_date
    return unformated_date.to_date.gregorian.inspect.gsub /.*,\s*/, ""
  end

end
