object @user
node do |u|
  { id: u.id, name: u.name, email: u.email, roles: u.roles, created_at: u.created_at.to_formatted_s(:long), updated_at: u.updated_at.to_formatted_s(:long) }
end