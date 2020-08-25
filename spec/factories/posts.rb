FactoryGirl.define do
    factory :post do
      date Date.today
      rationale "Post1"
      user
    end
  
    factory :second_post, class: "Post" do
      date Date.yesterday
      rationale "Post2"
      user
    end
end