import Config

config :hello, Hello.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",
  password: System.get_env("DB_PASSWORD") || "",
  hostname: System.get_env("DB_HOSTNAME") || "localhost"

config :hello, HelloWeb.Endpoint, secret_key_base: System.get_env("SECRET_KEY_BASE")
