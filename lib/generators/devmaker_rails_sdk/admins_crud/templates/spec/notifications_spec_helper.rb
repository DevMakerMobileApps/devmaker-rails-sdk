module RSpecNotificationSpecHelper
  def expect_to_send_notification(notificationClass, with:)
    notif = double(notificationClass)
    expect(notif).to receive(:send!).and_return(true)
    expect(notificationClass).to receive(:new).with(with).and_return(notif)
  end
end
