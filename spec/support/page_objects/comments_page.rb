class CommentsPage < BasePage
  set_url routes.comments_path

  element :header, '.header'
  element :notice, '#notice'
end
