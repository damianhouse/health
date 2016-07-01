class AboutsController < ApplicationController


    def welcome

    end

    def aboutus

    end

    def ourcoaches

    end

    def testimonials

    end


    def signupconfirmation

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
  end
