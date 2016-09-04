class AboutsController < ApplicationController
  before_action :logged_in?, only: [:signupconfirmation]

    def welcome

    end

    def aboutus

    end

    def ourcoaches
      @coaches = Coach.all
    end

    def recipes
      @recipe = Recipe.new.random_recipe
    end

    def testimonials

    end


    def signupconfirmation
      @stripe_list = Stripe::Plan.all
      @plans = @stripe_list[:data]
    end

    def terms

    end

    def survey

    end

    def survey_results
      @coach1 = Coach.find_by(id: 1)
      @coach2 = Coach.find_by(id: 2)
      @coach3 = Coach.find_by(id: 3)
    end

    def screenshots
    end

    def thank_you
    end
  end
