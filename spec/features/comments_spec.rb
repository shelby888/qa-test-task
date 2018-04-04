require 'rails_helper'

describe 'Posts spec' do
  let(:comments_page) { CommentsPage.new }
  let(:new_comment_page) { NewCommentPage.new }
  let(:comment_page) {CommentPage.new}

  # Тест проверяет переход на страницу создания комментария по уникальному заголовку
  it 'should move to new comment page' do
    comments_page.load
    click_link 'New Comment'
    expect(find('h1')).to have_content('New Comment')
  end

  # Тест проверяет сообщение после успешного создания комментария
  it 'should create new comment and check the message' do
    post = create :post
    new_comment_page.load
    new_comment_page.post_id_field.set post.id
    new_comment_page.body_field.set 'Post body'
    new_comment_page.create_comment_button.click
    expect(comment_page.notice).to have_content('Comment was successfully created.')
  end
end
