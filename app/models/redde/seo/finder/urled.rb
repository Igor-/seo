module Redde::Seo::Finder::Urled
  def find_url_seo
    return default_or_existing_urled_seo if urled_seo_from_db
    create_urled_seo
    default_seo
  end

  def default_or_existing_urled_seo
    return default_seo if urled_seo_from_db.empty?
    urled_seo_from_db
  end

  def urled_seo_from_db
    @urled_seo ||= ::Redde::Seo.where(url: url).try(:first)
  end

  def create_urled_seo
    s = Redde::Seo.new(url: url, skip_basic_validation: true)
    s.save if url.present?
  end
end
