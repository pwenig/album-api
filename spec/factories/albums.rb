FactoryGirl.define do
  factory :album do
   album {Faker::Beer.name}
   genre "Rock"
   year "1975"
   artist_id nil

  end


end