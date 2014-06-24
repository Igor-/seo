# Redde Seo

[![Build Status](https://travis-ci.org/redde/seo.svg?branch=master)](https://travis-ci.org/redde/seo)
[![Code Climate](https://codeclimate.com/github/redde/seo.png)](https://codeclimate.com/github/redde/seo)

Seo helper for Redde rails projects

## Installation

Add `redde_seo` to your Gemfile:

	gem 'redde_seo'
	
Mount engine in your `routes.rb`:

	mount ReddeSeo::Engine, at: '/redde/seo'
	namespace :admin do
      resources :seos do
        get 'all', on: :collection
      end
    end
	
Install migrations:

	rake redde_seo_engine:install:migrations
	
Migrate database:

	rake db:migrate
	
## Usage

Add concern to model:

	include WithSeo
	
Add concern to `ApplicationController`:

	include WithSeoCtrl
	
Define `seo_object` method when needed:

	# products_controller.rb
	...
	
	def seo_object
	  return @product if @product
	  nil
	end
	
Insert this block in the end of the form (before submit):

	...	
	= render "admin/seos/block", f: f
	
	= f.submit
	
### Templated Seo

If you want to use templated seo:

Create necessary directory structure:

	mkdir -p app/models/redde/seo
	
Add custom class name to `app/models/redde/seo/custom_class_names.rb`:

	module Redde::Seo::CustomClassNames
      NAMES = ['Product']
    end
    
Create template for your model (Product):

    # app/models/redde/seo/product_seo.rb

    class Redde::Seo::ProductSeo
      attr_accessor :product
      def initialize(product)
        @product = product
      end

      def empty?
        false
      end

      def title
        "#{product.name.gsub('\r\n', ' ')} hop"
      end

      def description
        "#{title}"
      end

      def keywords
        ''
      end
    end
