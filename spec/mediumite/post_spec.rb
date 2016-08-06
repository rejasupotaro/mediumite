require "spec_helper"

describe Mediumite::Post do
  describe "#under_publication?" do
    context "publication_id is not given" do
      it "returns false" do
        post = Mediumite::Post.new(title: "title", body: "body")
        expect(post.under_publication?).to be false
      end
    end

    context "publication_id is given" do
      it "returns true" do
        post = Mediumite::Post.new(title: "title", body: "body", publication_id: 123)
        expect(post.under_publication?).to be true
      end
    end
  end

  describe "#to_json" do
    context "just given title and body" do
      it "has given title and body" do
        json = JSON.parse(Mediumite::Post.new(title: "title", body: "body").to_json)
        expect(json["title"]).to eq "title"
        expect(json["contentFormat"]).to eq "markdown"
        expect(json["content"]).to eq "body"
        expect(json["canonicalUrl"]).to be_nil
        expect(json["tags"]).to be_nil
        expect(json["publishStatus"]).to eq "draft"
      end
    end

    context "with format" do
      it "overwrites contentFormat" do
        json = JSON.parse(Mediumite::Post.new(format: "html").to_json)
        expect(json["title"]).to be_nil
        expect(json["contentFormat"]).to eq "html"
        expect(json["content"]).to be_nil
        expect(json["canonicalUrl"]).to be_nil
        expect(json["tags"]).to be_nil
        expect(json["publishStatus"]).to eq "draft"
      end
    end

    context "with canonicalUrl" do
      it "overwrites canonicalUrl" do
        json = JSON.parse(Mediumite::Post.new(canonical_url: "https://github.com").to_json)
        expect(json["title"]).to be_nil
        expect(json["contentFormat"]).to eq "markdown"
        expect(json["content"]).to be_nil
        expect(json["canonicalUrl"]).to eq "https://github.com"
        expect(json["tags"]).to be_nil
        expect(json["publishStatus"]).to eq "draft"
      end
    end

    context "with tags" do
      it "overwrites tags" do
        json = JSON.parse(Mediumite::Post.new(tags: ["Rails", "Cooking"]).to_json)
        expect(json["title"]).to be_nil
        expect(json["contentFormat"]).to eq "markdown"
        expect(json["content"]).to be_nil
        expect(json["canonicalUrl"]).to be_nil
        expect(json["tags"]).to include("Rails", "Cooking")
        expect(json["publishStatus"]).to eq "draft"
      end
    end

    context "with publish_status" do
      it "overwrites publish_status" do
        json = JSON.parse(Mediumite::Post.new(publish_status: "public").to_json)
        expect(json["title"]).to be_nil
        expect(json["contentFormat"]).to eq "markdown"
        expect(json["content"]).to be_nil
        expect(json["canonicalUrl"]).to be_nil
        expect(json["tags"]).to be_nil
        expect(json["publishStatus"]).to eq "public"
      end
    end
  end
end
