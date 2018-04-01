require 'rails_helper'

describe 'Posts spec' do
  let(:posts_page) { PostPage.new }
  let(:new_post_page) { NewPostPage.new }
#  let(:post) { create :post }

  it 'Open posts list' do
    posts_page.load
    expect(posts_page).to have_header
  end

  it 'Open new post page' do
    posts_page.load
    click_link 'New Post'
    expect(find('h1')).to have_content('New Post')
  end

  it 'Create new post and check notice' do
    posts_page.load
    visit('/posts/new')
    fill_in('post_title', with: 'Title One')
    fill_in('post_body', with: 'Body One')
    click_button('Create Post')
    expect(find('#notice')).to have_content('Post was successfully created.')
  end

  it 'Create new post and check entered data' do
    new_post_page.load
    new_post_page.title_field.set 'Title1'
    new_post_page.body_field.set 'Body1'
    click_button('Create Post')
    expect(find(:xpath, ".//p[2]")).to have_content('Title1')
    expect(find(:xpath, ".//p[3]")).to have_content('Body1')
  end

  it 'Should not create post without Title' do
    new_post_page.load
    fill_in('post_body', with: 'Body1')
    click_button('Create Post')
    expect(find('#notice')).to have_no_content('Post was successfully created.')
  end

  xit 'should check Show link' do
    post = create :post, title: 'test_title'
    visit("/posts/#{post.id}")
    sleep 5
  end
end
