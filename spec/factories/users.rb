FactoryGirl.define do
    sequence :email do |n|
        "test#{n}@example.com"
    end

    factory :user do
        first_name 'Foo'
        last_name 'Bar'
        email {generate :email}
        password "asdfasdf"
        password_confirmation "asdfasdf"
    end

    factory :admin_user, class: "AdminUser" do
        first_name 'Admin'
        last_name 'User'
        email {generate :email}
        password "asdfasdf"
        password_confirmation "asdfasdf"
    end

    factory :no_user, class: "User" do
        first_name 'Non'
        last_name 'Authorized'
        email {generate :email}
        password "asdfasdf"
        password_confirmation "asdfasdf"
    end
end