# coding: utf-8
class Admin::SeosController < Admin::BaseController
  def index
    @seos = Seo.empty
  end

  def all
    @seos = Seo.all
    render 'index'
  end

  def new
    @seo = Seo.new
    render 'edit'
  end

  def edit
    @seo = Seo.find(params[:id])
  end

  def create
    @seo = Seo.new(seo_params)
    redirect_or_edit(@seo.save)
  end

  def update
    @seo = Seo.find(params[:id])
    redirect_or_edit(@seo.update_attributes(seo_params))
  end

  def destroy
    @seo = Seo.find(params[:id])
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

  def notice_for(obj)
    "#{obj.class.model_name.human} сохранен."
  end

  def url_for_obj(obj)
    return [:edit, :admin, obj] if params[:commit] == 'Применить'
    [:admin, obj.class.model_name.plural.to_sym]
  end
end
