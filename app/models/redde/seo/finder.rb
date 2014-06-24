class Redde::Seo::Finder
  include Objected
  include Urled

  attr_accessor :url, :object, :result

  def initialize(url, object = nil)
    @url = url
    @object = object
  end

  def find
    @result = find_object_seo if object.present?
    @result = find_url_seo if result.nil?
    @result = default_seo if result.nil?
    @result
  end

  def default_seo
    Redde::Seo::DefaultSeo.new
  end
end
