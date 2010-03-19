Feature: Register a project
  In order to control my projects
  As a logged user
  I want to register a project giving its name, repository url, description,
  programming language, application domain. Also giving the avaliation
  periodicity.

  Scenario: Registering a project
    Given I visit '/projects/new'
    When I fill the project form with '<project_name>', '<repository_url>' and '<description>'
    And I click on the 'Register Project' button
    Then I should see the message <message>
    
    Exemples:
    | project_name |          repository_url              |        description         |           message               |
    |  Mezuro Web  | git://github.com/paulormm/mezuro.git | Metrics project analisator | Project successfully registered |
    |    | git://github.com/paulormm/mezuro.git | Metrics project analisator | Missing projects name |
    |  Mezuro Web  |  | Metrics project analisator | Missing projects repository_url |

