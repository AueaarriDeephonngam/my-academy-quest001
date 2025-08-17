FactoryBot.define do
  factory :quest do
    title { "Complete a sample task" }
    done { false }

    trait :completed do
      done { true }
    end

    trait :with_long_title do
      title { "This is a very long quest title that might test the length validations and UI display" }
    end
  end
end
