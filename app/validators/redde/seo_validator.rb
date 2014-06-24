class Redde::SeoValidator
  attr_accessor :seo

  def initialize(seo)
    @seo = seo
  end

  def validate
    empty_fields
    if valid?
      check_controller_uniqueness
      check_object_uniqueness
    end
  end

  def valid?
    !seo.errors.any?
  end

  def edit_or_create_count
    seo.persisted? ? 1 : 0
  end

  def check_controller_uniqueness
    @seo.errors[:base] << 'Нарушение уникальности привязки. Два разных сео не могут быть привязаны к одному url' if url_present? && Redde::Seo.where(url: seo.url).count > edit_or_create_count
  end

  def check_object_uniqueness
    @seo.errors[:base] << 'Нарушение уникальности привязки. Два разных сео не могут быть привязаны к одному объекту' if object_present? && Redde::Seo.where(seoable_type: @seo.seoable_type, seoable_id: @seo.seoable_id).count > edit_or_create_count
  end

  def empty_fields
    @seo.errors[:base] << 'Отсутствует привязка. Сео дожно быть привязано к экшену контроллера или объекту' unless any_field_present?
  end

  def any_field_present?
    url_present? || object_present?
  end

  def all_fields_present?
    url_present? && object_present?
  end

  def url_present?
    seo.url.present?
  end

  def object_present?
    seo.seoable_type.present?
  end
end
