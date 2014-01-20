object @user
node do |u|
  { name: u.name, email: u.email, created_at: u.created_at.to_formatted_s(:long) }
end