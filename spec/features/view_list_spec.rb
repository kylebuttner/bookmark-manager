feature 'View all links' do
  scenario 'return a list of all saved links' do
    Link.create(url: 'http://www.google.com', title: 'Google')
    visit '/links'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end
