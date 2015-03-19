require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#send_message" do
    before(:each) do
      @zach = User.create!
      @david = User.create!
    end

    context "when the user is under their subscription limit" do
      before(:each) do
        @zach.subscription = Subscription.new
        allow(@zach.subscription).to receive(:can_send_message?) { true }
      end
      it "sends a message to another user" do
        msg = @zach.send_message(
            :title => "Book Update",
            :text => "Beta 11 includes great stuff!",
            :recipient => @david
        )
        expect(@david.received_messages).to eq [msg]
      end

      it "creates a new message with the submitted attributes" do
        msg = @zach.send_message(
            :title => "Book Update",
            :text => "Beta 11 includes great stuff!",
            :recipient => @david
        )
        expect(msg.title).to eq "Book Update"
        expect(msg.text).to eq "Beta 11 includes great stuff!"

      end

      it "adds the message to the sender's sent messages" do
        msg = @zach.send_message(
            :title => "Book Update",
            :text => "Beta 11 includes great stuff!",
            :recipient => @david
        )
        expect(@zach.sent_messages).to eq [msg]
      end

    end

    context "when the user is over their subscription limit" do
      before(:each) do
        @zach.subscription = Subscription.new
        allow(@zach.subscription).to receive(:can_send_message?).and_return(false)
      end

      it "does not create a message" do
        expect(
            lambda {
              @zach.send_message(
                :title => "Book Update",
                :text => "Beta 11 includes great stuff!",
                :recipient => @david
              )
            }
        ).not_to change(Message, :count)
      end
    end

  end

end
