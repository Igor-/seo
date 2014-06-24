# coding: utf-8

require 'spec_helper'

describe Redde::Seo::Finder do
  let(:product) { FactoryGirl.create(:product) }
  let(:url) { '/url' }
  let(:with_url) { Redde::Seo::Finder.new(url, nil) }
  let(:with_product) { Redde::Seo::Finder.new(url, product) }

  context 'EMPTY' do
    let(:seo) { Redde::Seo.create(seoable_id: product.id, seoable_type: product.class.name, skip_basic_validation: true) }
    it 'возвращает дефолтное сео, если найденное сео пустое' do
      seo
      expect(with_product.find.title).to eq Redde::Seo::ProductSeo.new(product).title
    end
  end

  context 'PRODUCT' do
    it 'создает сео и возвращает дефолтное' do
      expect(with_product.find.title).to eq Redde::Seo::ProductSeo.new(product).title
      expect(Redde::Seo.count).to eq 0
    end
  end

  context 'CONTROLLER' do
    it 'создает сео для контроллера' do
      expect(with_url.find.title).to eq Redde::Seo::DefaultSeo.new.title
      expect(Redde::Seo.first.url).to eq url
    end
  end
end
