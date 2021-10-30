module Types
  class WeatherType < Types::BaseObject
    # field: :query名 , 型, null: nullを許可するか, description: 'クエリの説明'
    field :weather, String, null: false, description: '天気'
    def weather
      # object: { weather: '晴れ', temperature: 60 }
      object[:weather]
    end

    field :temperature, Int, null: false, description: '温度'
    def temperature
      object[:temperature]
    end
  end
end