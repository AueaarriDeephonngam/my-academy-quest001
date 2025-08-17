# Additional step definitions for full application workflow

Then('I should see the header with consistent styling') do
  expect(page).to have_css('.brag-header')
  expect(page).to have_css('.page-title')
  expect(page).to have_css('.subtitle')
end

Then('I should see proper navigation elements') do
  expect(page).to have_link('Back to Quests')
  expect(page).to have_css('.back-btn')
end

Then('I should see the quest interface with consistent styling') do
  expect(page).to have_css('.quest-app-container')
  expect(page).to have_css('.quest-card')
  expect(page).to have_css('.header')
  expect(page).to have_css('.add-quest-section')
end

Then('I should see {string} in the goals section') do |text|
  within('.goals-section') do
    expect(page).to have_content(text)
  end
end
