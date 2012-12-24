# Load the rails application
require File.expand_path('../application', __FILE__)

# Load APP configuration
APP_CONFIG = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]

# Initialize the rails application
Love4movies::Application.initialize!
