Feature: Register a project
  In order to control my projects
  As a logged user
  I want to register a project giving its name, repository url, description,
  programming language, application domain. Also giving the avaliation
  periodicity.

  Scenario: Registering a project
    Given I visit the project register page
    When I fill the project form with "<project_name>", "<repository_url>",
    "<description>", "<programming_language>" and "<application_domain>"
    And click on the 'Register' button
    Then the number of existent products should be increased by one <<<TERMINAR
    And I should be sent to the new product's page <<<TERMINAR
