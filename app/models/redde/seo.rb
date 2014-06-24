# coding: utf-8

class Redde::Seo < ActiveRecord::Base
  attr_accessor :skip_basic_validation

  belongs_to :seoable, polymorphic: true

  scope :for_url, ->(u) { where(url: u) }
  scope :for_object, ->(o) { where(seoable_type: o.class.name, seoable_id: o.id) }
  scope :empty, -> { where("title is null or title = '' or keywords is null or keywords = '' or description is null or description = ''") }

  validates :title, :keywords, :description, length: { minimum: 5 }, allow_blank: true, unless: :skip_basic_validation

  validate do |seo|
    Redde::SeoValidator.new(seo).validate
  end

  def empty?
    !(title.present? && keywords.present? && description.present?)
  end
end
