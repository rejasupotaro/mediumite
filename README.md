# Mediumite [![CircleCI](https://circleci.com/gh/rejasupotaro/mediumite.svg?style=svg)](https://circleci.com/gh/rejasupotaro/mediumite)

This is simple wrapper for the Medium API written in Ruby.
For full API documentation, see [Medium/medium-api-docs: Documentation for Medium's OAuth2 API](https://github.com/Medium/medium-api-docs#32-publications)

# Usage

## Authentication

In order to publish on behalf of a Medium account, you will need an access token. Medium  offers two ways to acquire an access token: browser-based OAuth authentication, and self-issued access tokens. Currently this library supports only self-issued access tokens.

You can generate/revoke an access token from the [Settings page](https://medium.com/me/settings) of your Medium account.

Using the access token, initlize `Mediumite::Client`.

```ruby
client = Mediumite::Client.new(token: your_access_token)
```

## Resources

### Users

#### Getting the authenticated user’s details

Returns details of the user who has granted permission to the application.

Example:

```ruby
> client.user
=> {:id=>"5303d74c64f66366f00cb9b2a94f3251bf5",
  :username=>"majelbstoat",
  :name=>"Jamie Talbot",
  :url=>"https://medium.com/@majelbstoat",
  :imageUrl=>"https://images.medium.com/0*fkfQiTzT7TlUGGyI.png"}
```

### Publications

#### Listing the user’s publications

Returns a full list of publications that the user is related to in some way: This includes all publications the user is subscribed to, writes to, or edits.

Example:

```ruby
> client.get_publications
=> [{:id=>"b969ac62a46b",
  :name=>"About Medium",
  :description=>"What is this thing and how does it work?",
  :url=>"https://medium.com/about",
  :imageUrl=>"https://cdn-images-1.medium.com/fit/c/200/200/0*ae1jbP_od0W6EulE.jpeg"}
,
  {:id=>"b45573563f5a",
  :name=>"Developers",
  :description=>"Medium’s Developer resources",
  :url=>"https://medium.com/developers",
  :imageUrl=>"https://cdn-images-1.medium.com/fit/c/200/200/1*ccokMT4VXmDDO1EoQQHkzg@2x.png"}
]
```

### Posts

#### Creating a post

Creates a post on the authenticated user’s profile.

Example:

```ruby
> post = Mediumite::Post.new(title: "Liverpool FC", body: "# Liverpool FC\nYou’ll never walk alone.")
> client.create_post(post)
=> {:id=>"e6f36a",
  :title=>"Liverpool FC",
  :authorId=>"5303d74c64f66366f00cb9b2a94f3251bf5",
  :url=>"https://medium.com/@majelbstoat/liverpool-fc-e6f36a",
  :canonicalUrl=>"http://jamietalbot.com/posts/liverpool-fc",
  :publishStatus=>"draft",
  :publishedAt=>1442286338435,
  :license=>"",
  :licenseUrl=>"https://medium.com/policy/9db0094a1e0f"
  :tags=>[]}
```

You can specify these parameters below.

| Parameter | Type | Required? | Description |
|----|----|----|----|
| title | string | required | The title of the post. |
| body | string | required | The body of the post, in a valid, semantic, markdown or HTML fragment. Further markups may be supported in the future. For a full list of accepted HTML tags, see [here](https://medium.com/@katie/a4367010924e). |
| format | string | optional | The format of the "body" field. There are two valid values, "markdown", and "html". The default is "markdown" |
| publish_status | string | optional | The status of the post. Valid values are “public”, “draft”, or “unlisted”. The default is “draft”. |
| tags | string array | optional | Tags to classify the post. Only the first three will be used. Tags longer than 25 characters will be ignored. |
| publication_id | string | optional | The publication id. The post will associate with the given publication. |
