require "fcm"

module DevmakerRailsSdk
  class FcmPushNotificate
    attr_accessor :fcm_server_key, :title, :body, :device_tokens, :details

    MAX_USER_IDS_PER_CALL = 1000

    def initialize(fcm_server_key:, device_tokens:, title:, body:, details: {})
      @fcm_server_key = fcm_server_key
      @device_tokens = device_tokens
      @title = title
      @body = body
      @details = details
    end

    def send!
      return false if device_tokens.blank?

      device_tokens.each_slice(MAX_USER_IDS_PER_CALL) do |device_ids|
        fcm_client.send(device_ids, fcm_notification)
      end

      true
    end

    private

    def fcm_client
      @fcm_client ||= FCM.new(fcm_server_key)
    end

    def fcm_notification
      {
        priority: "high",
        notification: {
          title: title,
          body: body,
          details: details,
        },
        data: {
          title: title,
          body: body,
          details: details,
        },
      }
    end
  end
end
