class ApplicationController < ActionController::Base
  include Pagy::Backend

  attr_accessor :css_files

  before_action :load_base_css

  private

  def load_base_css
    @css_files = []
  end
end
