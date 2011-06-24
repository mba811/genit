# -*- encoding: utf-8 -*-

module Genit

  # Build the web site.
  class Compiler
  
    def initialize working_dir
      @working_dir = working_dir
    end
  
    def compile
      load_files
      build_files
      write_files
    end
    
    private
    
    def load_files
      @template = HtmlDocument.open(File.join(@working_dir, 'templates/main.html'))
      @page_content = HtmlDocument.open_as_string(File.join(@working_dir, 'pages/index.html'))
    end
    
    def build_files
      tag = @template.at_css("body genit")
      tag.replace @page_content
    end
    
    def write_files
      fileout = @template.to_html
      File.open(File.join(@working_dir, 'www/index.html'), "w") do |file| 
        file.puts fileout
      end
    end
    
  end
  
end
