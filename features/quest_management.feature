Feature: Quest Management
  As a user
  I want to manage my quests
  So that I can track my daily goals and achievements

  Background:
    Given I am on the quests page

  Scenario: View empty quest list
    Given there are no quests
    When I visit the quest page
    Then I should see "Ready to start your quest journey!"
    And I should see "No quests yet!"
    And I should see "Add your first quest above to get started"

  Scenario: Add a new quest
    Given there are no quests
    When I fill in "Add new quest..." with "Learn Cucumber testing"
    And I click the add quest button
    Then I should see "Learn Cucumber testing" in the quest list
    And I should see "1 quest"
    And I should see "0 completed"

  Scenario: Add multiple quests
    Given there are no quests
    When I add a quest "Complete project documentation"
    And I add a quest "Review code changes"
    And I add a quest "Attend team meeting"
    Then I should see "3 quests"
    And I should see "0 completed"
    And I should see all the quests in the list

  Scenario: Complete a quest
    Given there is a quest "Finish the report"
    When I check the quest "Finish the report"
    Then the quest "Finish the report" should be marked as completed
    And I should see "1 quest"
    And I should see "1 completed"

  Scenario: Uncomplete a quest
    Given there is a completed quest "Review documents"
    When I uncheck the quest "Review documents"
    Then the quest "Review documents" should be marked as pending
    And I should see "1 quest"
    And I should see "0 completed"

  Scenario: Delete a quest
    Given there are quests:
      | title               | done  |
      | Write test cases    | false |
      | Deploy application  | true  |
    When I delete the quest "Write test cases"
    Then I should not see "Write test cases" in the quest list
    And I should see "1 quest"
    And I should see "Deploy application" in the quest list

  Scenario: Quest management workflow
    Given there are no quests
    When I add a quest "Plan the sprint"
    And I add a quest "Design the interface"
    And I check the quest "Plan the sprint"
    And I add a quest "Implement features"
    Then I should see "3 quests"
    And I should see "1 completed"
    And the quest "Plan the sprint" should be marked as completed
    And the quest "Design the interface" should be marked as pending
    And the quest "Implement features" should be marked as pending

  Scenario: Navigate to brag document
    When I click on "My brag document"
    Then I should be on the brag document page
    And I should see "Aoom Development Goals"

  Scenario: Quest form validation
    When I try to submit an empty quest
    Then the quest should not be added
    And I should still be on the quest page

  Scenario: Quest display order
    Given there are quests created in this order:
      | title           | created_at    |
      | First quest     | 3 days ago    |
      | Second quest    | 1 day ago     |
      | Third quest     | 1 hour ago    |
    When I visit the quest page
    Then the quests should be displayed in reverse chronological order:
      | Third quest  |
      | Second quest |
      | First quest  |
