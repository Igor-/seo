# coding: utf-8

class Redde::Seo::Finder
  include Urled

  attr_accessor :url, :object, :result, :object_seo

  def initialize(url, object = nil)
    @url = url
    @object = object
  end

  def find
    @result = find_object_seo if object.present?
    @result = find_url_seo if result.nil? || (result && result.empty?)
    @result = default_seo if result.nil? || (result && result.empty?)
    @result
  end

  def find_object_seo
    Redde::Seo::Finder::Objected.new(url, object).find
  end

  def default_seo
    Redde::Seo::DefaultSeo.new
  end
end
