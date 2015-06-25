json.array! @groups do |group|
  json.group_name group.group_name
  json.contacts do
    json.array! group.grouped_contacts do |contact|
      json.(contact, :name, :email)
    end
  end
end
