def sign_up
  visit 'users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'dave@gov.uk'
  fill_in :password, with: 'budgetcuts'
  click_button 'Sign up'
end
