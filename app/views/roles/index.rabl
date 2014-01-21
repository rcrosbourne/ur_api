collection @roles
node do |r|
  { id: r.id, name: r.name, description: r.description, policies: r.policies, created_at: r.created_at.to_formatted_s(:long), updated_at: r.updated_at.to_formatted_s(:long) }
end