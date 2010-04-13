Feature: Register a user
In order to create an account
As a new user
I want to register an user giving my login, password and e-mail

  Scenario Outline: Registering a user
  Given I visit /users/new
  When I fill the user form with '<my_login>', '<my_password>', '<my_password_confirmation>' and '<my_email>'
  And I click on the 'Create User' button
  Then I should see the message <message>
    
  Examples:
    |  my_login    | my_password | my_password_confirmation |      my_email          |          message                        |
    |  paulormm    | paulinho123 |      paulinho123         |  paulormm@american.com | User successfully created               |
    |  terceiro    | jogueduro   |     wrong_password       |   terceiro@teste.com   | Password doesn't match confirmation     |
    |  terceiro    | jogueduro   |     jogueduro            |                        | Email is too short                      |
    |  terceiro    | jogueduro   |     jogueduro            |       terceiro         | Email should look like an email address |
    |              | paulinho123 |     paulinho123          |  paulormm@american.com | Login is too short                      |

