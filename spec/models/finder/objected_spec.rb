# coding: utf-8

require 'spec_helper'

describe Redde::Seo::Finder::Objected do
  let(:finder) { Redde::Seo::Finder.new(url, object) }

  let(:seo) { create(:seo, seoable_type: object.class.name, seoable_id: object.id, title: 'Product', url: url) }
  let(:url) { '/url' }
  let(:seo1) { create(:seo, url: '/') }
  let(:object) { FactoryGirl.create(:article) }

  it 'finds valid seo' do
    seo; seo1
    expect(finder.find.title).to eq 'Product'
  end
end
