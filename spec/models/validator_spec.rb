# coding: utf-8

require 'spec_helper'

describe Redde::SeoValidator do
  let(:seo) { create(:seo, seoable_type: 'Article', seoable_id: 1, skip_basic_validation: true) }

  it 'saves seo with url' do
    seo.seoable_type = nil; seo.seoable_id = nil
    expect(seo.valid?).to eq true
  end

  it 'saves seo with object' do
    seo.url = nil
    expect(seo.valid?).to eq true
  end

  it 'does not save empty seo' do
    seo.url = nil; seo.seoable_type = nil; seo.seoable_id = nil
    expect(seo.valid?).to eq false
  end

  it 'saves seo with url and object' do
    expect(seo.valid?).to eq true
  end

  it 'does not create seo with same urls' do
    seo.seoable_type = nil; seo.seoable_id = nil
    seo.save
    nseo = Redde::Seo.new(url: '/url')
    expect(nseo.valid?).to eq false
  end

  it 'does not save seo with same objects' do
    seo.url = nil
    seo.save
    nseo = Redde::Seo.new(seoable_type: 'Article', seoable_id: 1)
    expect(nseo.valid?).to eq false
  end
end
