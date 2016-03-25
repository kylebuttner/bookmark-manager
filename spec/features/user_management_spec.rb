feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, dave@gov.uk!')
    expect(User.last.email).to eq('dave@gov.uk')
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'must sign up with email' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'email must have valid format' do
    expect { sign_up(email: 'invalid') }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'user cannot sign up with existing email' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end
end
feature 'User sign in' do

  let(:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'with correct credentials' do
    sign_in(user.email, user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  it 'does not authenticate when given an incorrect password' do
    expect(User.authenticate(user.email, 'wrong_stupid_password')).to be_nil
  end

end

feature 'User sign out' do
  let!(:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end
end
