require 'rails_helper'

# Once an event's page only shows edit and delete option for the event creator, these tests will
# need to be modified/deleted
describe 'Try to edit a post that is not yours', type: :feature do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user1_event) { create(:event, creator_id: user1.id)}

  before do
    login_as(user2, scope: :user)
  end

  it 'User2 tries to edit User1s post' do
    visit(edit_event_path(user1_event))
    expect(page).to_not have_content('Edit Your Table')
  end
end
