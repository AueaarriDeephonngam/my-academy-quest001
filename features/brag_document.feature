Feature: Brag Document
  As a user
  I want to view my development goals and achievements
  So that I can track my professional growth and accomplishments

  Background:
    Given I am on the brag document page

  Scenario: View brag document header
    When I visit the brag document page
    Then I should see "Aoom Development Goals"
    And I should see "UX/UI Designer Journey & Achievements"
    And I should see a back to quests link

  Scenario: View all goal sections
    When I visit the brag document page
    Then I should see the following sections:
      | Goals                |
      | Self Development     |
      | Team Collaboration   |
      | ODT Academy         |
      | Client Success       |

  Scenario: View goals section content
    When I visit the brag document page
    Then I should see the goals section with:
      | UX/UI Designer Excellence |
      | Technology Trends         |
      | Personal Goal            |
      | Typing Mastery           |
      | IELTS Achievement        |

  Scenario: View self development activities
    When I visit the brag document page
    Then I should see self development activities:
      | Design Inspiration |
      | Trend Following    |
      | Weekly Practice    |

  Scenario: View team collaboration activities
    When I visit the brag document page
    Then I should see team collaboration activities:
      | Design Consultation |
      | Creative Concepts   |

  Scenario: View ODT Academy goals
    When I visit the brag document page
    Then I should see ODT Academy goals:
      | Academy Spirit        |
      | Active Participation  |

  Scenario: View client success achievement
    When I visit the brag document page
    Then I should see the client success section
    And I should see "Project Delivery"
    And I should see "ส่งมอบโปรเจ็คที่ตรงตามที่ลูกค้าต้องการ"

  Scenario: Navigate back to quests
    When I visit the brag document page
    And I click on the back to quests button
    Then I should be on the quests page

  Scenario: View specific goal details
    When I visit the brag document page
    Then I should see "55 WPM" in the typing mastery goal
    And I should see "95%" in the typing mastery goal
    And I should see "5+" in the IELTS achievement goal
    And I should see "1 ครั้งต่อสัปดาห์" in the weekly practice activity

  Scenario: Check responsive design elements
    When I visit the brag document page
    Then all sections should have proper icons
    And the page should have proper styling
    And the header should have a background image

  Scenario: Verify all external links and icons
    When I visit the brag document page
    Then I should see Font Awesome icons throughout the page
    And all sections should be properly formatted
    And the page should be mobile responsive

  Scenario: Complete user journey from quest to brag document and back
    Given I am on the quests page
    When I click on "My brag document"
    Then I should be on the brag document page
    And I should see "Aoom Development Goals"
    When I click on the back to quests button
    Then I should be on the quests page
    And I should see "Auearee Deephonngam"
