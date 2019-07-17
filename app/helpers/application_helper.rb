module ApplicationHelper
  def user_avatar(user, size=40)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize: "#{size}x#{size}!"), class: "rounded-circle")
    else
      image_tag("default_avatar.png", size: "#{size}x#{size}")
    end
  end
end
