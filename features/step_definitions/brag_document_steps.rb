Given('I am on the brag document page') do
  visit brag_document_path
end

When('I visit the brag document page') do
  visit brag_document_path
end

Then('I should see a back to quests link') do
  expect(page).to have_link('Back to Quests', href: quests_path)
end

Then('I should see the following sections:') do |table|
  table.raw.flatten.each do |section_name|
    expect(page).to have_content(section_name)
  end
end

Then('I should see the goals section with:') do |table|
  within('.goals-section') do
    table.raw.flatten.each do |goal_title|
      expect(page).to have_content(goal_title)
    end
  end
end

Then('I should see self development activities:') do |table|
  within('.self-section') do
    table.raw.flatten.each do |activity|
      expect(page).to have_content(activity)
    end
  end
end

Then('I should see team collaboration activities:') do |table|
  within('.team-section') do
    table.raw.flatten.each do |activity|
      expect(page).to have_content(activity)
    end
  end
end

Then('I should see ODT Academy goals:') do |table|
  within('.odt-section') do
    table.raw.flatten.each do |goal|
      expect(page).to have_content(goal)
    end
  end
end

Then('I should see the client success section') do
  expect(page).to have_css('.client-section')
  within('.client-section') do
    expect(page).to have_content('Client Success')
  end
end

When('I click on the back to quests button') do
  click_link 'Back to Quests'
end

Then('I should be on the quests page') do
  expect(current_path).to eq(quests_path)
end

Then('I should see {string} in the typing mastery goal') do |text|
  within('.goal-card.skill', text: 'Typing Mastery') do
    expect(page).to have_content(text)
  end
end

Then('I should see {string} in the IELTS achievement goal') do |text|
  within('.goal-card.language', text: 'IELTS Achievement') do
    expect(page).to have_content(text)
  end
end

Then('I should see {string} in the weekly practice activity') do |text|
  within('.self-section') do
    expect(page).to have_content(text)
  end
end

Then('all sections should have proper icons') do
  # Check that each section has Font Awesome icons
  expect(page).to have_css('.section-icon i.fas')
  expect(page).to have_css('.goal-icon i.fas')
  expect(page).to have_css('.dev-icon i')
  expect(page).to have_css('.activity-icon i.fas')
  expect(page).to have_css('.odt-icon i.fas')
  expect(page).to have_css('.achievement-icon i.fas')
end

Then('the page should have proper styling') do
  # Check for main CSS classes
  expect(page).to have_css('.brag-document')
  expect(page).to have_css('.brag-header')
  expect(page).to have_css('.brag-content')
  expect(page).to have_css('.brag-section')
end

Then('the header should have a background image') do
  expect(page).to have_css('.brag-header.with-image')
end

Then('I should see Font Awesome icons throughout the page') do
  # Verify various Font Awesome icons are present
  icon_classes = [
    '.fa-target',     # Goals icon
    '.fa-paint-brush', # UX/UI Designer icon
    '.fa-rocket',     # Technology Trends icon
    '.fa-umbrella-beach', # Personal Goal icon
    '.fa-keyboard',   # Typing Mastery icon
    '.fa-globe',      # IELTS icon
    '.fa-user-graduate', # Self Development icon
    '.fa-users',      # Team Collaboration icon
    '.fa-graduation-cap', # ODT Academy icon
    '.fa-handshake',  # Client Success icon
    '.fa-award'       # Achievement icon
  ]

  icon_classes.each do |icon_class|
    expect(page).to have_css("i#{icon_class}")
  end
end

Then('all sections should be properly formatted') do
  # Check that all main sections exist and are properly structured
  sections = [
    '.goals-section',
    '.self-section',
    '.team-section',
    '.odt-section',
    '.client-section'
  ]

  sections.each do |section|
    expect(page).to have_css(section)
    within(section) do
      expect(page).to have_css('.section-header')
      expect(page).to have_css('.section-icon')
    end
  end
end

Then('the page should be mobile responsive') do
  # Check for responsive design elements (this is a basic check)
  # In a real scenario, you might want to resize the window and test mobile-specific behavior
  expect(page).to have_css('.brag-document')

  # Check that viewport meta tag is present
  expect(page).to have_css('meta[name="viewport"]', visible: false)
end
