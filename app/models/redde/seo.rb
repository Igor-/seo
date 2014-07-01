# coding: utf-8

class Redde::Seo < ActiveRecord::Base
  paginates_per 50
  attr_accessor :skip_basic_validation

  belongs_to :seoable, polymorphic: true

  scope :for_url, ->(u) { where(url: u) }
  scope :for_object, ->(o) { where(seoable_type: o.class.name, seoable_id: o.id) }
  scope :empty, -> { where("title is null or title = '' or keywords is null or keywords = '' or description is null or description = ''") }
  scope :full, -> { where("char_length(title) > 0 AND char_length(keywords) > 0 AND char_length(description) > 0") }
  scope :for_type, ->(u) { where(seoable_type: u) }

  validates :title, :keywords, :description, length: { minimum: 5 }, allow_blank: true, unless: :skip_basic_validation

  validate do |seo|
    Redde::SeoValidator.new(seo).validate
  end

  def empty?
    !(title.present? && keywords.present? && description.present?)
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Seo')
  end

  def self.categories
    self.select('seos.seoable_type, COUNT(*) AS type_count').group('seos.seoable_type')
      .inject({}) do |res, t|
        if t.seoable_type
          name = "#{t.seoable_type.constantize.model_name.human} (#{t.type_count})"
        else
          name = "Без привязки (#{t.type_count})"
        end
        res.merge(name => t.seoable_type)
    end
  end

  def self.for_empty(empty = nil)
    return self.all if empty.nil?
    return self.empty if empty == 'true'
    self.full
  end
end
