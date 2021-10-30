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

    field :month, MonthType, null: false, description: '月の情報(月を指定して1件)' do
      argument :month_num, Int, '月の数字', required: true
    end
    def month(month_num:)
      month_hash_array[month_num - 1]
    end

    field :months, [MonthType], null: :false, description: '月の情報(全件)'
    def months
      month_hash_array
    end

    # 返すためのデータ
    def month_hash_array
      [
        { name: 'January',   days: 31 },
        { name: 'February',  days: 28 },
        { name: 'March',     days: 31 },
        { name: 'April',     days: 30 },
        { name: 'May',       days: 31 },
        { name: 'June',      days: 30 },
        { name: 'July',      days: 31 },
        { name: 'August',    days: 31 },
        { name: 'September', days: 30 },
        { name: 'October',   days: 31 },
        { name: 'November',  days: 30 },
        { name: 'December',  days: 31 }
      ]
    end

    field :user, UserType, null: false, description: 'ユーザ情報(id指定で1件)' do
      argument :id, Int, 'ユーザid', required: true
    end
    def user(id:)
      User.find_by(id: id)
    end

    field :users, [UserType], null: false, description: 'ユーザ情報(全件)'
    def users
      User.all
    end
  end
end
