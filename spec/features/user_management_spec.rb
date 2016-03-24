feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, dave@gov.uk!')
    expect(User.last.email).to eq('dave@gov.uk')
  end
end
