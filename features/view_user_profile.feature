Feature: View a user profile
In order to view information of the user and their projects
As a user
I want to view user information such as avatar, name, email, website, company,
localization, member since. Also view the list of user's projects. Each project 
with its name, last analysis, and status. Status options can be calculated, 
a progress message, or an erro message.

  Scenario: Viewing a user profile with its information
  When I am logged in as 'paulormm'
  And I visit /paulormm
  Then I should see the user name 'paulormm'
  And I should see the user e-mail 'paulormm@qualquercoisa.com'
  And I should see the membership since '28 May 2010'
  And I should see a 'Public Projects' heading
  And I should see project 'Kalibro' with last analysis '28 May 2010' and status 'Metrics calculated'
  And I should see project 'Project In Progress' with last analysis '08 Jun 2010' and status 'Analysis in progress'
  And I should see project 'Error Project' with last analysis '30 May 2010' and status 'Error Found'
