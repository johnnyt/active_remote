require "bundler"
require "sinatra"
require "pry"
require "active_support/json/encoding"

class Tag
  @@counter = 0
  @@store = Hash.new

  attr_accessor :guid, :name, :updated_at, :user_guid

  def self.store
    @@store
  end

  def self.create(attributes={})
    new_tag = new(attributes)
    new_tag.save
  end

  def initialize(attributes={})
    @guid = attributes[:guid]
    @name = attributes[:name]

    set_guid if @guid.nil?
  end

  def save
    @updated_at = Time.now
    @@store[guid] = self
  end

  def to_hash
    {
      guid: guid,
      name: name,
      updated_at: updated_at,
      user_guid: user_guid
    }
  end

  private

  def set_guid
    @@counter += 1
    @guid = "TAG-#{@@counter}"
  end
end

Tag.create guid: "foo", name: "Foo"

get "/tags" do
  content_type :json
  tags = 
  Tag.store.values.map{|t|t.to_hash}.to_json
end

post "/tags" do
  content_type :json
  tag = Tag.create params
  tag.to_hash.to_json
end
