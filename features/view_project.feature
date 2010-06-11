Feature: View a project
In order to view information of the project
As a user
I want to view a project with its name, repository url, description,
programming language, application domain. Also giving the avaliation
periodicity. Also view the project metrics, if it is already calculated,
or a progress message, when the system is calculating it.

  Scenario: Viewing a project with its information and calculated metrics
  When I visit /projects/jmeter
  Then I should see the name 'Jmeter'
  And I should see the url 'git@github.com/jmeter'
  And I should see the description 'Jmeter project description'
  And I should see metric 'total_tloc' with value 26.0
  And I should see metric 'accm_mode' with value 2.0

  Scenario: Viewing a project with svn error
  When I visit /projects/error-project
  Then I should see the name 'Error Project' 
  And I should see the url 'error'
  And I should see the description 'Error!!!'
  And I should see the error message "Blue screen of death"
  
  Scenario: Viewing a project with its information without calculated metrics
  When I visit /projects/in-progress
  Then I should see the name 'Project In Progress' 
  And I should see the url 'git@github.com/in_progress'
  And I should see the description 'Project with metrics in progress'
  And I should see a progress message

