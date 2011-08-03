# -*- encoding: utf-8 -*-

module Genit

  # Modify menu links.
  class MenuBuilder < BuilderBase
  
    # Public: Build the menu of a particular page.
    #
    # page_name - The string filename of the page to build menu for.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, menu_links
    end
    
    private
    
    def menu_links
      @document.css("ul#menu a")
    end
    
    def update link
      @path = link['href']
      link['id'] = 'selected' if @path == @page_name.force_html_extension
      nb = BuilderBase::get_number_of_base_dirs @page_name
      make_relative nb
      link['href'] = @path
    end
  
  end
  
end
