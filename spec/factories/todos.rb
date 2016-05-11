FactoryGirl.define do

  factory :todo do
    sequence(:title) { |n| "This is todo #{n.to_s.humanize}" }
  end


end
