module Admin
  module UsersHelper
    def user_roles
      User.roles.keys.map do |role|
        [ t(role, scope: "roles"), role ]
      end
    end
  end
end