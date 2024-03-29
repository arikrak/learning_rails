module UsersHelper

   #returns user gravatar

  def gravatar_for(user, options = {size: 30})    #small default
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size= options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")

  end
end
