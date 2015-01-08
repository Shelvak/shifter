Fabricator(:shift) do
  auto_worker_name  { 'Generic' }
  worker_id         { Fabricate(:worker).id }
  kind              { [true, false].sample }
end
