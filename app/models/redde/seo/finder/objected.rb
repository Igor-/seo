# coding: utf-8

module Redde::Seo::Finder::Objected
  def find_object_seo
    return templated_object_seo if templated?
    find_object_seo_from_db
  end

  def object_class_name
    @object.class.name
  end

  def templated?
    Redde::Seo::CustomClassNames::NAMES.include? object_class_name
  end

  def templated_object_seo
    "Redde::Seo::#{object_class_name}Seo".constantize.new(@object)
  end

  def find_object_seo_from_db
    return default_or_existing_object_seo if object_seo_from_db
    create_object_seo
    default_seo
  end

  def default_or_existing_object_seo
    return default_seo if object_seo_from_db.empty?
    object_seo_from_db.update(url: @url) unless object_seo_from_db.url != @url
    object_seo_from_db
  end

  def object_seo_from_db
    @object_seo ||= Redde::Seo.where(seoable_type: @object.class.name, seoable_id: @object.id).try(:first)
  end

  def create_object_seo
    s = Redde::Seo.new(seoable_id: @object.id, seoable_type: @object.class.name, url: @url, skip_basic_validation: true)
    s.save if @object.try(:id) && @object.try(:class).try(:name)
  end
end
