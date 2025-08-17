Feature: Full Application Workflow
  As a user
  I want to navigate between quest management and brag document
  So that I can track both my daily tasks and professional development

  Scenario: Complete user journey through the application
    Given I am on the quests page
    And there are no quests
    
    # Start with quest management
    When I add a quest "Complete Cucumber E2E tests"
    And I add a quest "Review brag document content"
    Then I should see "2 quests"
    And I should see "0 completed"
    
    # Complete one quest
    When I check the quest "Complete Cucumber E2E tests"
    Then I should see "1 completed"
    
    # Navigate to brag document
    When I click on "My brag document"
    Then I should be on the brag document page
    And I should see "Aoom Development Goals"
    And I should see "UX/UI Designer Journey & Achievements"
    
    # Verify brag document content
    And I should see "Goals"
    And I should see "Self Development"
    And I should see "Team Collaboration"
    And I should see "ODT Academy"
    And I should see "Client Success"
    
    # Navigate back to quests
    When I click on the back to quests button
    Then I should be on the quests page
    And I should see "2 quests"
    And I should see "1 completed"
    And the quest "Complete Cucumber E2E tests" should be marked as completed
    And the quest "Review brag document content" should be marked as pending

  Scenario: Cross-platform consistency check
    Given I am on the quests page
    When I click on "My brag document"
    Then I should be on the brag document page
    And I should see the header with consistent styling
    And I should see proper navigation elements
    When I click on the back to quests button
    Then I should be on the quests page
    And I should see the quest interface with consistent styling

  Scenario: Data persistence across page navigation
    Given I am on the quests page
    And there are no quests
    
    # Create multiple quests with different states
    When I add a quest "Design the new feature"
    And I add a quest "Write documentation"
    And I add a quest "Test the application"
    And I check the quest "Design the new feature"
    And I check the quest "Write documentation"
    
    # Navigate away and back
    When I click on "My brag document"
    And I click on the back to quests button
    
    # Verify data persisted
    Then I should see "3 quests"
    And I should see "2 completed"
    And the quest "Design the new feature" should be marked as completed
    And the quest "Write documentation" should be marked as completed  
    And the quest "Test the application" should be marked as pending

  Scenario: Navigation between pages maintains state
    Given I am on the quests page
    And I add a quest "Learn Cucumber BDD"
    
    # Navigate to brag document and verify quest remains
    When I click on "My brag document"
    Then I should be on the brag document page
    
    # Navigate back and verify quest is still there
    When I click on the back to quests button
    Then I should be on the quests page
    And I should see "Learn Cucumber BDD" in the quest list
    And I should see "1 quest"

  Scenario: User workflow with quest management and goal tracking
    Given I am on the quests page
    And there are no quests
    
    # Add quests related to professional development
    When I add a quest "Practice UI design patterns"
    And I add a quest "Study typography principles"
    And I add a quest "Complete IELTS practice test"
    
    # View professional goals
    When I click on "My brag document"
    Then I should be on the brag document page
    And I should see "IELTS Achievement" in the goals section
    And I should see "UX/UI Designer Excellence" in the goals section
    And I should see "Typing Mastery" in the goals section
    
    # Go back and complete relevant quest
    When I click on the back to quests button
    And I check the quest "Complete IELTS practice test"
    
    # Verify completion tracking
    Then I should see "3 quests"
    And I should see "1 completed"
    And the quest "Complete IELTS practice test" should be marked as completed
