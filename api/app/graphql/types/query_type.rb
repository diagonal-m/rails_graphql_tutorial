module Types
  class QueryType < Types::BaseObject
    field :posts, [Types::PostType], null: false
    def posts
      Post.all
    end

    field :post, Types::PostType, null: false do
      argument :id, Int, required: false
    end
    def post(id:)
      Post.find(id)
    end

    # 参考: https://spirits.appirits.com/type/technology/7055/
    field :current_date, String, null: false, description: '今日の日付'
    def current_date
      Date.today.strftime("%Y年 %m月 %d日")
    end

    field :today_weather, WeatherType, null: false, description: '今日の天気'
    def today_weather
      # ↓の値がWeatherTypeに渡される
      { weather: '晴れ', temperature: 60 }
    end
  end
end
