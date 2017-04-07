module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: :small })
    image_tag(user.image_url(:size), alt: user.name, class: "gravatar")
  end
end