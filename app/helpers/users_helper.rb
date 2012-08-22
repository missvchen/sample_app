module UsersHelper
  # Resturns the Gravatar (http://gavatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gavatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gavatar_url, alt: user.name, class: "gravatar")
  end
end
