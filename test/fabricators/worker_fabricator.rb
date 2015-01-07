Fabricator(:worker) do
  name           { Faker::Name.name }
  last_name      { Faker::Name.name }
  identification { Faker::Code.ean }
  address        { Faker::Address.street_address }
  phone          { Faker::PhoneNumber.cell_phone }
  occupation     { Faker::Company.name }
end
