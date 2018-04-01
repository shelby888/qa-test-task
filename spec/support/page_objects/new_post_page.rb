class NewPostPage < BasePage
  set_url routes.new_post_path

  element :title_field, '#post_title'
  element :body_field, '#post_body'
  element :create_post_button, 'Create Post'
end
