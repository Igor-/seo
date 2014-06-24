module WithSeoCtrl
  extend ActiveSupport::Concern

  def seo_block
    @seo_block ||= Seo::Finder.new(request.path, seo_object).find
  end
  helper_method :seo_block

  def seo_object
    nil
  end
end
