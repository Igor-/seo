FactoryGirl.define do
  factory :seo, class: Redde::Seo do
    title { FFaker::Company.name }
    keywords { FFaker::Company.name }
    description { FFaker::Company.name }
    url '/url'
  end
end
