module ApplicationHelper
  def has_authority?(object)
    return false unless user_signed_in?
    current_user.id == object.user.id
  end
end
