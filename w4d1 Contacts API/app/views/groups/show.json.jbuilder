  json.group_name @group.group_name
  json.contacts @group.grouped_contacts do |contact|
    json.(contact, :name, :email)
  end
