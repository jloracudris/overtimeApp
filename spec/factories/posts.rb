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

    factory :post_from_another_user , class: "Post" do
      date Date.yesterday
      rationale "Post from another user"
      no_user
    end
end