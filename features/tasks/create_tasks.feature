@domain @api
Feature: Creates a task

  As a user I can add a task to a project
  and manage its state in order to track the work that needs to be done.
  Once a task is done a text message is sent to the user phone

  Valid states transitions:
   - todo -> in_progress
   - in_progress -> todo
   - in_progress -> done

  Rules:
  - Project is required
  - Name is required
  - Created tasks should default to "todo" state

  Background:
    Given a project

  Scenario: Creating a task with all fields
    When I create a task
    Then there is a task with these attributes:
      | NAME        | STATE  | DESCRIPTION   |
      | Sample Task | todo   | A sample task |


  Scenario: Trying to create a task without a name
    When I try to create a task without a name
    Then the system has 0 tasks
    And I get the error "Name can't be blank"


  Scenario: Creating a task without a state
    When I create a task without a state
    Then there is a task with the state "todo"
