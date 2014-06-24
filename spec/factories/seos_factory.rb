FactoryGirl.define do
  factory :seo, class: Redde::Seo do
    title { Faker::Company.name }
    keywords { Faker::Company.name }
    description { Faker::Company.name }
    url '/url'
  end
end
