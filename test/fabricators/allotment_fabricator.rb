Fabricator(:allotment) do
  owner_id    { Fabricate(:worker).id }
  place       { Faker::Address.state_abbr }
end
