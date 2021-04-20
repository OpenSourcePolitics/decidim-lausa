# frozen_string_literal: true

require "spec_helper"

describe Decidim::ProfileUpdatedEvent do
  include_context "when a simple event"

  let(:event_name) { "decidim.events.users.profile_updated" }
  let(:resource) { create :user, nickname: nickname }
  let(:nickname) { generate(:nickname) }
  let(:author) { resource }

  it_behaves_like "a simple event", true

  describe "email_subject" do
    it "is generated correctly" do
      expect(subject.email_subject).to eq("@#{resource.nickname} updated their profile")
    end

    context "when title has diacritics" do
      let(:nickname) { "H'i" }

      it "is generated correctly" do
        expect(subject.email_subject).to be_kind_of(String)
        expect(subject.email_subject).to eq("@H'i updated their profile")
        expect(subject.email_subject).not_to include("&#39;")
      end
    end
  end

  describe "email_intro" do
    it "is generated correctly" do
      expect(subject.email_intro)
        .to eq("The <a href=\"#{author_presenter.profile_url}\">profile page</a> of #{resource.name} (@#{resource.nickname}), who you are following, has been updated.")
    end
  end

  describe "email_outro" do
    it "is generated correctly" do
      expect(subject.email_outro)
        .to eq("You have received this notification because you are following @#{resource.nickname}. You can stop receiving notifications following the previous link.")
    end
  end

  describe "notification_title" do
    it "is generated correctly" do
      expect(subject.notification_title).to include("<a href=\"#{author_presenter.profile_path}\">profile page</a>")
    end
  end
end
