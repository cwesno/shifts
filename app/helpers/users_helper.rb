module UsersHelper

  def deactivate_link(user = @user)
    active = user.is_active?(current_department)
    link_to (active ? "Deactivate" : "Restore"), toggle_user_path(user), method: :post, remote: true, class: 'toggle_link'   
  end

  def determine_class(user)
    if u = User.where(login: user.login).first
      if u.departments.include?(current_department)
        "stop"
      else
        "caution"
      end
    else
      "notspecial"
    end
  end

  def determine_auth_type(user,l)
    if u = User.where(login: user.login).first
      if u.auth_type == l
        true
      else
        false
      end
    else
      if l == "CAS"
        true
      else
        false
      end
    end
  end

  def should_be_checked(user)
    if User.where(login: user.login).first && User.where(login: user.login).first.departments.include?(@department)
      false
    else
      true
    end
  end
end
