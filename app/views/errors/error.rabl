object @error
attributes :error_code, :error_description
attributes :error_list, :if => lambda { |m| !m.error_list.nil? }