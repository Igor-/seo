require 'spec_helper'

describe Redde::Seo::Finder do
  let(:finder) { Redde::Seo::Finder.new(url, object) }

  context 'FOR URL' do
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

  context "FOR OBJECT" do
    let(:seo) { Redde::Seo.create(seoable_type: object.class.name, seoable_id: object.id, title: "Product", description: "Product description", keywords: "Product") }
    let(:url) { "/url" }
    let(:seo1) { Redde::Seo.create(url: "/", title: "index title", description: "Oh my description", keywords: "Keywords") }
    let(:object) { FactoryGirl.create(:article) }

    it "достает правильное сео" do
      seo; seo1
      expect(finder.find.title).to eq "Product"
    end
  end

  context "FOR TEMPLATE OBJECT" do
    let(:url) { "/url" }
    let(:object) { FactoryGirl.create(:product) }
    let(:finder) { Redde::Seo::Finder.new(url, object) }

    it "возвращает true для использования кастом сео" do
      expect(finder.templated?).to eq true
    end

    it "достает правильное сео для продуктов" do
      expect(finder.find.title).to eq Redde::Seo::ProductSeo.new(object).title
      expect(Redde::Seo.count).to eq 0
    end
  end
end
