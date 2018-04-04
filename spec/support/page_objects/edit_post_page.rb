class EditPostPage < BasePage
  set_url routes.edit_post_path

  element :title_field, '#post_title'
  element :body_field, '#post_body'
  element :create_post_button, 'input[type=submit]'
end
