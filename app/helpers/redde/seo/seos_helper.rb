# coding: utf-8

module Redde::Seo::SeosHelper
  def seo_empty_link(name, key = nil)
    return name if params[:empty].to_s == key.to_s
    link_to name, url_for(params.permit!merge(empty: key))
  end

  def seo_type_link(name, key)
    link_to name, url_for(params.permit!merge(seoable_type: key)), class: ['phead-tabs__link', ('_active' if params[:seoable_type] == key)]
  end

  def seo_link_for_url(seo)
    link_to seo_url_for(seo), [:edit, :admin, seo], alt: seo.url, title: seo.url
  end

  def seo_url_for(seo)
    title = CGI.unescape(seo.url || '')
    title = truncate(title, length: 40)
    title.present? ? title : 'НЕ ЗАПОЛНЕНО'
  end

  def seo_link_for_object(seo)
    link_to seo_object_for(seo), [:edit, :admin, seo], alt: seo.url, title: seo.url
  end

  def seo_object_for(seo)
    return '' unless seo.seoable
    "#{seo.seoable.class.model_name.human}##{seo.seoable_id}"
  end

  def seo_title_for(seo)
    title = seo.title.present? ? truncate(seo.title, length: 17) : 'НЕ ЗАПОЛНЕНО'
    link_to title, [:edit, :admin, seo], alt: seo.url, title: seo.url
  end

  def seo_empty_for(seo)
    seo.empty? ? '✘' : '✔'
  end
end
