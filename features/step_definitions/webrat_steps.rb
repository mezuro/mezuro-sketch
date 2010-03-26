require File.expand_path(File.join(File.dirname(__FILE__), "..", "suport"))

Given /^I visit (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^I fill the project form with '(.+?)', '(.+?)' and '(.+)'$/ do |project_name, repository_url , description|
    fill_in('project_name', :with => project_name)
    fill_in('project_repository_url', :with => repository_url)
    fill_in('project_description', :with => description)
end

When /^I click on the '(.*?)' button$/ do |button|
    click_button(button)
end

Then /^I should see the message (.*)$/ do |text|
  response.should contain(text)
end
