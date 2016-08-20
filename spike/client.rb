require 'rubygems'
require 'bundler'

Bundler.require(:default, :development, :test)

ActiveRemote.config.adapter = :http

class TagService
  include HTTParty
  base_uri 'http://localhost:4567'

  def search(request)
    self.class.get "/tags?#{request.to_query}"
  end

  def create(request)
    self.class.post("/tags", body: request)
  end

  def update(request)
    self.class.post("/tags/#{request[:guid]}", body: request)
  end

  def delete(request)
    self.class.delete("/tags/#{request[:guid]}")
  end
end

class Tag < ::ActiveRemote::Base
  attribute :guid
  attribute :name
  attribute :updated_at
  attribute :user_guid
end
