Feature: department_test
  In order to manage departments
  As a superuser admin
  I want to be able to create and manage departments
  
  Scenario: Add department
    Given I have no departments
    And I am on the list of departments
    When I follow "New Department"
    And I fill in "Name" with "STC"
    And I press "Submit"
    Then I should see "Successfully created department"
    And I should have 1 department
    
  Scenario: Department list
    Given I have a department named "STC"
    And I have a department named "Film Studies"
    And I have a user named "Bob", netid "bq9"
    And the user with netid "bq9" belongs to the department "STC"
    And I am on the list of departments
    Then I should see "STC"
    And I should see "Film Studies"
    And I should see "STC"
    And I should have 2 departments
    When I choose to view "STC"
    Then I should see "Bob"
    And I should see "bq9"
