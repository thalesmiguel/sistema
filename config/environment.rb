# Load the Rails application.
require_relative 'application'

Time::DATE_FORMATS[:data_formatada] = "%d/%m/%Y - %H:%M"
Time::DATE_FORMATS[:data_banco] = "%Y-%m-%d"
Time::DATE_FORMATS[:hora_banco] = "%H:%M"

# Initialize the Rails application.
Rails.application.initialize!
