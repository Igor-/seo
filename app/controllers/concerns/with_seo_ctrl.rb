module WithSeoCtrl
  extend ActiveSupport::Concern

  included do
    helper_method :seo_block
  end

  def seo_block
    @seo_block ||= Redde::Seo::Finder.new(request.path, seo_object).find
  end

  def seo_object
    nil
  end
end
