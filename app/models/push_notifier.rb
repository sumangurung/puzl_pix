module PushNotifier
  def self.notify(device_token, text)
    APNS.send_notification(device_token, text)
  end
end
