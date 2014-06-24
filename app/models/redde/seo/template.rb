# coding: utf-8

class Redde::Seo::Template
  attr_accessor :objekt
  def initialize(objekt)
    @objekt = objekt
  end

  def empty?
    false
  end

  def title
    ''
  end

  def description
    ''
  end

  def keywords
    ''
  end

  def text
    ''
  end
end
