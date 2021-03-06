module ChallengeNotifier
  def self.notify(challenge)
    message = "You have been challenged!"
    notifications = challenge.challengees.map do |challengee|
      player = Player.find_by fb_id: challengee.fb_id
      player.device_tokens.map do |device_token|
        APNS::Notification.new(
          device_token.token,
          message
        )
      end
    end.flatten

    APNS.send_notifications(notifications) unless notifications.empty?
  end
end
