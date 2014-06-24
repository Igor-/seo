# coding: utf-8

require 'spec_helper'

describe Redde::SeoValidator do
  let(:seo) { create(:seo, seoable_type: 'Article', seoable_id: 1, skip_basic_validation: true) }

  it "Сохраняет сео с url" do
    seo.seoable_type = nil; seo.seoable_id = nil
    expect(seo.valid?).to eq true
  end

  it "Сохраняет сео с объектом" do
    seo.url = nil
    expect(seo.valid?).to eq true
  end

  it "не сохраняет пустое сео" do
    seo.url = nil; seo.seoable_type = nil; seo.seoable_id = nil
    expect(seo.valid?).to eq false
  end

  it "сохраняет сео с url и объектом" do
    expect(seo.valid?).to eq true
  end

  it "не сохраняет сео с одинаковыми url" do
    seo.seoable_type = nil; seo.seoable_id = nil
    seo.save
    nseo = Redde::Seo.new(url: "/url")
    expect(nseo.valid?).to eq false
  end

  it "не сохраняет сео с одинаковыми объектами" do
    seo.url = nil
    seo.save
    nseo = Redde::Seo.new(seoable_type: "Article", seoable_id: 1)
    expect(nseo.valid?).to eq false
  end
end
