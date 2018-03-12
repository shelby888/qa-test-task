class PostPage < BasePage
  set_url routes.post_path

  element :header, '.header'
end
