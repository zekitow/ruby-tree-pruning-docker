# frozen_string_literal: true

def load_object_from_json(dir, name)
  full_fime_name_path = File.join("./spec/support/#{dir}", "#{name}.json")
  JSON.parse(File.open(full_fime_name_path, 'r').read, object_class: OpenStruct)
end
