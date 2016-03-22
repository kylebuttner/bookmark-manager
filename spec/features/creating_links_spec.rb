feature 'Add links' do
  scenario 'user should be able to add link' do
    visit '/links/new'
    fill_in :title, with: "The Guardian"
    fill_in :url, with: "http://www.theguardian.co.uk"
    click_button "Submit"

    within 'ul#links' do
      expect(page).to have_content 'The Guardian'
    end
  end
end
