require 'rails_helper'

describe 'Posts spec' do
  let(:posts_page) { PostsPage.new }
  let(:new_post_page) { NewPostPage.new }
  let(:post_page) { PostPage.new }
  let(:edit_post_page) { EditPostPage.new }
#  let(:post) { create :post }

  it 'Open posts list' do
    posts_page.load
    expect(posts_page).to have_header
  end

  # Тест проверяет переход на страницу создания поста по уникальному заголовку
  it 'Open new post page' do
    posts_page.load
    click_link 'New Post'
    expect(find('h1')).to have_content('New Post')
  end

  # Тест проверяет наличие сообщения после успешного создания поста
  it 'Create new post and check notice' do
    new_post_page.load
    new_post_page.title_field.set 'Post title'
    new_post_page.body_field.set 'Post body'
    new_post_page.create_post_button.click
    expect(post_page.notice).to have_content('Post was successfully created.')
  end

  # Тест проверяет что верно сохраняются данные введенные при создании поста
  it 'Create new post and check entered data' do
    new_post_page.load
    new_post_page.title_field.set 'Title1'
    new_post_page.body_field.set 'Body1'
    new_post_page.create_post_button.click
    expect(find(:xpath, ".//p[2]")).to have_content('Title1')
    expect(find(:xpath, ".//p[3]")).to have_content('Body1')
  end

  # Негативный тест. Проверяет что пост без заголовка не создается. Ожидаемо падает
  it 'Should not create post without Title' do
    new_post_page.load
    new_post_page.title_field.set ''
    new_post_page.body_field.set 'Post body'
    new_post_page.create_post_button.click
    expect(posts_page.notice).to have_no_content('Post was successfully created.')
  end

  # Тест проверяет что по клику на  Show  выполняется переход на страничку верного поста
  it 'should check Show link redirect to correct address' do
    post = create :post, title: 'test_title'
    posts_page.load
    click_link 'Show'
    expect(page.current_path).to eq("/posts/#{post.id}")
  end

  # Проверяет что выводятся все созданные посты
  it 'should check count of elements on posts page' do
    10.times { create :post }
    posts_page.load
    expect(page).to have_xpath(".//tbody/tr", :count =>10)
  end

  # Тест проверяет что после удаления пост не выводится в списке.
  # Тест падает, так как посты не удаляются и окно с алертом не появляется
  it 'should delete post' do
    post = create :post, title: 'test_title'
    posts_page.load
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_xpath(".//tbody/tr", :count =>0)
  end

  # Тест проверяет что после удаления появляется сообщение.
  # Тест падает, так как посты не удаляются и окно с алертом не появляется
  it 'should delete post' do
    post = create :post, title: 'test_title'
    posts_page.load
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    expect(posts_page.notice).to have_content('Post was successfully destroyed.')
  end

  # Тест проверяет что отмене удаления пост не удаляется и выводится в списке.
  # Тест падает, так как окно с алертом не появляется
  it 'should cancel deleting post' do
    post = create :post, title: 'test_title'
    posts_page.load
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.dismiss
    expect(page).to have_xpath(".//tbody/tr", :count =>1)
  end

  # Проверяет сообщение после успешного редактирования
  it 'should check message after editing' do
    post = create :post, title: 'test title'
    visit("/posts/#{post.id}/edit")
    edit_post_page.update_post_button.click
    expect(post_page.notice).to have_content('Post was successfully updated.')
  end

  # Проверяет что заголовок изменился после редактирования
  it 'should check saving title after editing' do
    post = create :post, title: 'test title'
    visit("/posts/#{post.id}/edit")
    edit_post_page.title_field.set 'Updated Title'
    edit_post_page.update_post_button.click
    expect(find(:xpath, ".//p[2]")).to have_content('Updated Title')
  end

  # Проверяет что заголовок изменился после редактирования
  it 'should check saving body after editing' do
    post = create :post, title: 'test title', body: 'qwerty'
    visit("/posts/#{post.id}/edit")
    edit_post_page.body_field.set 'Asdfg'
    edit_post_page.update_post_button.click
    expect(find(:xpath, ".//p[3]")).to have_content('Asdfg')
  end
end
