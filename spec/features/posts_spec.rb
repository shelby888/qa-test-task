require 'rails_helper'

describe 'Posts spec' do
  let(:posts_page) { PostPage.new }
  let(:post) { create :post }

  it 'Reset password for enabled user' do
    posts_page.load
    expect(posts_page).to have_header
  end
end
