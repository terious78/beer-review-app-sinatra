configure do
     if Sinatra::Application.development?
      set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite"
      }
    else
      db = URI.parse(ENV['DATABASE_URL'] || 'postgres://hiomxyxwoawmuy:jjqiXCQrb6SaN_gYREa5R44ruU@ec2-54-83-22-233.compute-1.amazonaws.com:5432/d8pa4vperieole')
      set :database, {
      adapter: "postgresql",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: "utf8"
      }

    end

      # Load all models from app/models, using autoload instead of require
      # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
        Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
        filename = File.basename(model_file).gsub('.rb', '')
        autoload ActiveSupport::Inflector.camelize(filename), model_file
      end

    end
