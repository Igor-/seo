# coding: utf-8

require 'spec_helper'

describe Redde::Seo::Finder do
  let(:finder) { Redde::Seo::Finder.new(url, object) }

  context 'Templated' do
    let(:url) { '/url' }
    let(:object) { FactoryGirl.create(:product) }
    let(:finder) { Redde::Seo::Finder::Objected.new(url, object) }

    it 'it returns true for templated seo' do
      expect(finder.templated?).to eq true
    end

    it 'returns valid templated seo' do
      expect(finder.find.title).to eq Redde::Seo::ProductSeo.new(object).title
    end

    it 'does not create empty seo' do
      expect(Redde::Seo.count).to eq 0
    end
  end
end
