require 'rails_helper'

describe 'Posts spec' do
  let(:posts_page) { PostPage.new }
  let(:post) { create :post }

  it 'Open posts list' do
    posts_page.load
    expect(posts_page).to have_header
  end

  it 'Open new post page' do
    posts_page.load
    click_link 'New Post'
    expect(find('h1')).to have_content('New Post')
  end
end
