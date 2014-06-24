# coding: utf-8

require 'spec_helper'

describe Redde::Seo do
  let(:product) { FactoryGirl.create(:product) }
  let(:url) { '/url' }
  let(:with_url) { Redde::Seo::Finder.new(url, nil) }
  let(:with_product) { Redde::Seo::Finder.new(url, product) }

  context 'CREATOR' do
    context 'EMPTY' do
      let(:seo) { create(:seo, seoable_id: product.id, seoable_type: product.class.name, skip_basic_validation: true, title: nil, keywords: nil, description: nil) }
      it 'returns templated seo if seo is not valid' do
        seo
        expect(with_product.find.title).to eq Redde::Seo::ProductSeo.new(product).title
      end
    end

    context 'PRODUCT' do
      it 'does not create seo for template' do
        expect(Redde::Seo.count).to eq 0
      end

      it 'returns templated seo' do
        expect(with_product.find.title).to eq Redde::Seo::ProductSeo.new(product).title
      end
    end

    context 'URL' do
      it 'creates seo for url' do
        with_url.find
        expect(Redde::Seo.first.url).to eq url
      end

      it 'returns default seo' do
        expect(with_url.find.title).to eq Redde::Seo::DefaultSeo.new.title
      end
    end
  end
end
