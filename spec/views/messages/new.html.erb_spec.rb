require 'rails_helper'

describe "messages/new.html.erb" do

  let(:message) do
    mock_model("Message").as_new_record.as_null_object
  end

  before do
    assign(:message, message)
  end

  it "renders a form to create a message" do
    render
    Capybara.string(rendered).find("form").tap do |form|
      expect(form).to have_selector("input[type='submit']")
    end

  end

  it "renders a text field for the message title" do
    #message.stub(:title => "the title")
    allow(message).to receive(:title) { "the title" }
    render
    Capybara.string(rendered).find("form").tap do |form|
      expect(form).to have_selector("input[type='text'][name='message[title]'][value='the title']")
    end
  end

  it "renders a text area for the message text" do
    allow(message).to receive(:text) { "the message" }
    render
    Capybara.string(rendered).find("form").tap do |form|
      expect(form).to have_selector("textarea[name='message[text]']",:text => "the message")
    end
  end
end
