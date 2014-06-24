# coding: utf-8

class Redde::Seo::Finder::Objected
  attr_accessor :url, :objekt, :seo

  def initialize(url, objekt)
    @url = url
    @objekt = objekt
    @seo = Redde::Seo.for_object(objekt).first
  end

  def find
    return updated_object_seo if seo && !seo.empty?
    return templated_seo if templated?
    create_seo
    default_seo
  end

  def default_seo
    Redde::Seo::DefaultSeo.new
  end

  def updated_object_seo
    update(url: url) if seo.url != url
    seo
  end

  def object_class_name
    objekt.class.name
  end

  def templated?
    Redde::Seo::CustomClassNames::NAMES.include? object_class_name
  end

  def templated_seo
    "Redde::Seo::#{object_class_name}Seo".constantize.new(objekt)
  end

  def objekt_params
    { seoable_id: objekt.id, seoable_type: objekt.class.name }
  end

  def seo_params
    objekt_params.merge(url: url)
  end

  def create_seo
    s = Redde::Seo.new(seo_params.merge(skip_basic_validation: true))
    s.save if objekt.try(:id) && objekt.try(:class).try(:name)
  end
end
