# coding: utf-8
class Admin::SeosController < Admin::BaseController
  before_action :set_categories
  def index
    @seos = Redde::Seo.for_empty(params[:empty]).for_type(params[:seoable_type]).page(params[:page])
  end

  def all
    @seos = Redde::Seo.all
    render 'index'
  end

  def new
    @seo = Redde::Seo.new
    render 'edit'
  end

  def edit
    @seo = Redde::Seo.find(params[:id])
  end

  def create
    @seo = Redde::Seo.new(seo_params)
    redirect_or_edit(@seo, @seo.save)
  end

  def update
    @seo = Redde::Seo.find(params[:id])
    redirect_or_edit(@seo, @seo.update_attributes(seo_params))
  end

  def destroy
    @seo = Redde::Seo.find(params[:id])
    @seo.destroy
    redirect_to admin_seos_path, notice: 'Seo удален.'
  end

  private

  def seo_params
    params.require(:seo).permit!
  end

  private

  def redirect_or_edit(obj, saved)
    if saved
      redirect_to url_for_obj(obj), notice: notice_for(obj)
    else
      render 'edit'
    end
  end

  def set_categories
    @categories = Redde::Seo.categories
  end

  def notice_for(obj)
    "#{obj.class.model_name.human} сохранен."
  end

  def url_for_obj(obj)
    return [:edit, :admin, obj] if params[:commit] == 'Применить'
    [:admin, obj.class.model_name.plural.to_sym]
  end
end
