class HomeController < ApplicationController
  before_action :load_css

  def index ; end

  private

  def load_css
    @css_files << 'home_index'
  end
end
