Feature: Register a project
In order to control my projects
As a logged user
I want to register a project giving its name, repository url, description,
programming language, application domain. Also giving the avaliation
periodicity.

  Scenario Outline: Registering a project
  When I am logged in as 'viviane'
  And I visit /projects/new
  When I fill the project form with '<project_name>', '<repository_url>' and '<identifier>'
  And I click on the 'Register Project' button
  Then I should see the message <message>
    
  Examples:
    | project_name |          repository_url              | identifier |           message               |
    |  Mezuro Web  | git://github.com/paulormm/mezuro.git | mezuro-web | Project successfully registered |
    |              | git://github.com/paulormm/mezuro.git | anything   | Name can't be blank             |
    |  Mezuro Web  |                                      | mezuro-any | Repository url can't be blank   |

