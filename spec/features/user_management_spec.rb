feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, dave@gov.uk!')
    expect(User.last.email).to eq('dave@gov.uk')
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'must sign up with email' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
  end

  scenario 'email must have valid format' do
    expect { sign_up(email: 'invalid') }.not_to change(User, :count)
  end
end
