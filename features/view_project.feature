Feature: View a project
In order to view information of the project
As a user
I want to view a project with its name, repository url, description,
programming language, application domain. Also giving the avaliation
periodicity. Also view the project metrics, if it is already calculated,
or a progress message, when the system is calculating it.

  Scenario: Viewing a project with its information and calculated metrics
  When I visit /projects/analizo
  Then I should see the name 'Analizo'
  And I should see the url 'git@github.com/analizo'
  And I should see the description 'Calculate metrics'
  And I should see metric 'loc' with value 5.0
  And I should see metric 'noc' with value 10.0

  Scenario: Viewing a project with its information without calculated metrics
  When I visit /projects/in_progress
  Then I should see the name 'Project In Progress' 
  And I should see the url 'git@github.com/in_progress'
  And I should see the description 'Project with metrics in progress'
  And I should see a progress message

  Scenario: Viewing a project with svn error
  When I visit /projects/error-project
  Then I should see the name 'Error Project' 
  And I should see the url 'error'
  And I should see the description 'Error!!!'
  And I should see the error message "Blue screen of death"
  


