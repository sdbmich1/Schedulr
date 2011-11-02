class PagesController < ApplicationController
  layout :page_layout

  private

  def page_layout
    "pages"
  end
end
