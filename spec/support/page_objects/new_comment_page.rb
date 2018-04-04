class NewCommentPage < BasePage
  set_url routes.new_comment_path

  element :post_id_field, '#comment_post_id'
  element :body_field, '#comment_body'
  element :create_comment_button, 'input[type=submit]'
end
