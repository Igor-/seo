# coding: utf-8

require 'spec_helper'

describe Redde::Seo::Finder::Urled do
  let(:finder) { Redde::Seo::Finder.new(url, object) }
  let(:seo) { FactoryGirl.create(:seo, url: '/url') }
  let(:seo1) { FactoryGirl.create(:seo, url: '/url1') }
  let(:url) { '/url' }
  let(:object) { nil }

  it 'Gets valid seo' do
    seo; seo1
    expect(finder.find.title).to eq seo.title
  end

  it 'Gets default seo' do
    expect(Redde::Seo::Finder.new('na', nil).find.title)
      .to eq Redde::Seo::DefaultSeo.new.title
  end
end
