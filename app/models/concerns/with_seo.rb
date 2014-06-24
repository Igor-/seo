module WithSeo
  extend ActiveSupport::Concern

  included do
    attr_accessible :seo_attributes if Rails.version.to_f < 4.0
    has_one :seo, as: :seoable, dependent: :destroy, class_name: 'Redde::Seo'
    accepts_nested_attributes_for :seo
  end
end
