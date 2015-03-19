class User < ActiveRecord::Base
  has_many :received_messages, :class_name => Message.name, :foreign_key => "recipient_id"
  has_many :sent_messages, :class_name => Message.name, :foreign_key => "sender_id"
  belongs_to :subscription, :class_name => "Subscription"

  def send_message(message_attr)
    if subscription.can_send_message?
      sent_messages.create! message_attr
    end
  end

end
