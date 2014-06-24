class Redde::Seo::ProductSeo
  attr_accessor :product
  def initialize(product)
    @product = product
  end

  def empty?
    false
  end

  def title
    "#{product.name.gsub('\r\n', ' ')}"
  end

  def description
    "#{title}"
  end

  def keywords
    ''
  end
end
