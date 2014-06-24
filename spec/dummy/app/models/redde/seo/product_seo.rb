# coding: utf-8

class Redde::Seo::ProductSeo < Redde::Seo::Template
  def title
    "#{objekt.name.gsub('\r\n', ' ')} hop"
  end

  def description
    "#{title}"
  end

  def keywords
    ''
  end

  def text
    title
  end
end
