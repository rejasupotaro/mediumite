require "spec_helper"

describe Mediumite::Client do
  let(:client) { Mediumite::Client.new(token: "access-token") }

  describe "instantiation" do
    it "masks token on inspect" do
      inspected = client.inspect
      expect(inspected).not_to include("access-token")
    end
  end

  describe "#token" do
    it "returns given token" do
      expect(client.token).to eq "access-token"
    end
  end

  describe "#create_post" do
    it "sends the expected params to Medium blog" do
      post = Mediumite::Post.new(
        title: "Test post title",
        body: "# Test post body",
        publication_id: "publication-id"
      )
      stub = stubbed_post_create(title: "Test post title", publication_id: "publication-id")

      response = client.create_post(post)

      expect(stub).to have_been_requested
    end
  end

  private

    def stubbed_post_create(title: "Test post title",
                            body: "# Test post body",
                            publication_id: "publication-id",
                            access_token: "access-token")
      response_headers = { "Content-Type" => "application/json" }

      stub_request(:post, "https://api.medium.com/v1/publications/#{publication_id}/posts").
        with(
          body: {
            title: title,
            contentFormat: "markdown",
            content: body,
            canonicalUrl: nil,
            tags: nil,
            publishStatus: "draft"
          }.to_json,
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
          }
        ).
        to_return(status: 200, body: <<~JSON, headers: response_headers)
          {
            "data": {
              "id": "e6f36a",
              "title": "Test post title",
              "authorId": "#{Random.hash}",
              "tags": [],
              "url": "https://medium.com/@mediumuser/test-post-title-e6f36a",
              "canonicalUrl": "http://example.com/posts/test-post-title",
              "publishStatus": "public",
              "publishedAt": #{Time.now.to_i},
              "license": "all-rights-reserved",
              "licenseUrl": "https://medium.com/policy/9db0094a1e0f"
            }
          }
        JSON
    end
end
