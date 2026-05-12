# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

if Rails.application.config.relative_url_root.present?
  map Rails.application.config.relative_url_root do
    run Rails.application
  end
else
  run Rails.application
end

Rails.application.load_server
