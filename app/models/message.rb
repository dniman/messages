class Message < ActiveRecord::Base
  belongs_to :recipient, :class_name => "User"

  validates_presence_of :title, :text, :recipient
end
