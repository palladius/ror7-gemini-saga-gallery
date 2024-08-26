class PagesController < ApplicationController
  def home
    @featured_image = Medium.best_image
  end

  def about
    @featured_image = Medium.best_image
  end



  def graphs
  end

  def contact
  end
end
