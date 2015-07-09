require 'rails_helper'

feature 'Commenting on a post' do
  let(:member)   { FactoryGirl.create(:member) }
  let(:post)     { FactoryGirl.create(:post, :author => member) }
  
  background do
    login_as(member)
    visit new_comment_path(:post_id => post.id)
  end

  scenario "creating a comment" do
    fill_in "comment_body", :with => "This is a sample test for comment"
    click_button "Post comment"
    expect(page).to have_content "Comment was successfully created"
    expect(page).to have_content "Posted by"
  end

  context "editing a comment" do
    let(:existing_comment) { FactoryGirl.create(:comment, :post => post, :author => member) }

    background do
      visit edit_comment_path(existing_comment)
    end

    scenario "saving edit" do
      fill_in "comment_body", :with => "Testing edit for comment"
      click_button "Post comment"  
      expect(page).to have_content "Comment was successfully updated"
      expect(page).to have_content "Edited by"
    end
  end

end