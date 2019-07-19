module AdminUser
  # Admins can accept/reject applications,
  # update any member's status,
  # see current member's dues,
  # open and close applications,
  # and manage new member setup.

  def make_admin!
    self.update_attributes(is_admin: true)
  end

  def unmake_admin!
    self.update_attributes(is_admin: false)
  end
end
