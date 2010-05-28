Feature: View a user profile
In order to view information of the user and their projects
As a user
I want to view user information such as avatar, name, email, website, company,
localization, member since. Also view the list of user's projects. Each project 
with its name, last analysis, and status. Status options can be calculated, 
a progress message, or an erro message.

  Scenario: Viewing a user profile with its information
  Given I visit /viviane
  Then I should see the user name 'viviane'
  And I should see the user e-mail 'vivi@qualquercoisa.com'
  And I should see the member since '28 May 2010'

  Scenario: Viewing the calculated project status
  Given I visit /viviane
  Then

