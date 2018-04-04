class CommentPage < BasePage
  set_url routes.comment_path

  element :header, '.header'
  element :notice, '#notice'
end
