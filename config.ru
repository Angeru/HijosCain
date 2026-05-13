# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# Caddy strips /backoffice from PATH_INFO before proxying but doesn't set
# SCRIPT_NAME, so inside a request Rails' url helpers fall back to an empty
# script_name and generate URLs without the prefix. Force it here.
if (prefix = Rails.application.config.relative_url_root)
  script_name_setter = Class.new do
    def initialize(app, prefix)
      @app = app
      @prefix = prefix
    end

    def call(env)
      env["SCRIPT_NAME"] = @prefix
      @app.call(env)
    end
  end

  run script_name_setter.new(Rails.application, prefix)
else
  run Rails.application
end

Rails.application.load_server
