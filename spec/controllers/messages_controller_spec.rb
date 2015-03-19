require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe "POST create" do
    let(:message) { mock_model(Message).as_null_object }

    before do
      #Message.stub(:new).and_return(message)
      allow(Message).to receive(:new) { message }
    end

    it "creates a new message" do
      #pending("drive out redirect")
      expect(Message).to receive(:new).with("text" => "a quick brown fox").and_return(message)
      post :create, :message => { "text" => "a quick brown fox" }
    end

    context "when the message saves successfully" do
      before do
        allow(message).to receive(:save) { true }
      end

      it "sets a flash[:notice] message" do
        post :create
        expect(flash[:notice]).to eq("The message was saved successfully.")
      end

      it "redirects to the Messages index" do
        post :create
        expect(response).to redirect_to(:action => "index")
      end
    end

    context "when the message fails to save" do
      before do
        allow(message).to receive(:save) { false }
      end

      it "assigns @message" do
        post :create
        expect(assigns[:message]).to eq(message)
      end

      it "renders the new template" do
        post :create
        expect(response).to render_template("new")
      end
    end
  end
end
