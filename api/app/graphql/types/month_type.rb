module Types
  class MonthType < Types::BaseObject
    field :name, String, null: false, description: '英名'
    def name
      object[:name]
    end

    field :days, Int, null: false, description: '日数'
    def days
      object[:days]
    end
  end
end