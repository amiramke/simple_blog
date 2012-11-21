Fabricator(:comment) do
  article
  body  { Faker::Lorem.paragraphs(1).join("\n") }
end