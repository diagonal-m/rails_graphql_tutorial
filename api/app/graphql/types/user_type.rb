module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :last_name, String, null: true
    field :first_name, String, null: true
    field :profile, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :full_name, String, null: false, description: '姓名'
    def full_name
      object.last_name + ' ' + object.first_name
    end

    field :created_at, String, null: false, description: '作成日時'
    def created_at
      object.created_at.strftime("%Y年 %m月 %d日")
    end

    field :profile, String, null: false, description: 'プロフィール'
    def profile
      object.profile
    end
  end
end
