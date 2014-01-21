collection @users
node do |u|
  { id: u.id, name: u.name, email: u.email, created_at: u.created_at.to_formatted_s(:long), roles: u.roles }
end