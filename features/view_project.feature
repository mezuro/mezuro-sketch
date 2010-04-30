Feature: View a project
In order to view information of the project
As a user
I want to view a project with its name, repository url, description,
programming language, application domain. Also giving the avaliation
periodicity. Also view the project metrics, if it is already calculated,
or a progress message, when the system is calculating it.

  Scenario: Viewing a project with its information and calculated metrics
  When I visit /projects/analizo
  Then I should see Analizo information
  And  I should see calculated metrics

  Scenario: Viewing a project with its information without calculated metrics
  When I visit /projects/analizo
  Then I should see Analizo information
  And  I should see a progress message

  


