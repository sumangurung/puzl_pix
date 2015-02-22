require 'apns'

APNS.host = Rails.configuration.apns_host
APNS.pem = Rails.configuration.apns_pem
APNS.port = Rails.configuration.apns_port
APNS.pass = Rails.configuration.apns_pass
