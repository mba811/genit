# -*- encoding: utf-8 -*-

require "fileutils"

module Genit

  # Create a skeleton project.
  class ProjectCreator
  
    # Sole constructor.
    #
    # name    - The String name of the future project folder.
    # doctype - The String document type definition.
    def initialize name, doctype
      @name = name
      @doctype = doctype
    end
    
    # Public: Create the structure of the project, that is many
    # files and folders.
    #
    # Returns nothing.
    def create
      begin
        create_the_project
      rescue SystemCallError
        puts "Cannot create project..."
      end
    end
    
    private
    
    def create_the_project
      FileUtils.makedirs @name
      create_dirs ['fragments', 'news', 'pages', 'scripts', 'styles', 'templates', 'www',
                   'styles/alsa', 'styles/yui', 'styles/images']
      copy_main_template
      copy_files ['templates/menu.html',
                  'pages/index.html', 'styles/handheld.css', 'styles/print.css',
                  'styles/screen.css', 'styles/alsa/all.css', 'styles/yui/all.css', 'styles/yui/base.css',
                  'styles/yui/fonts.css', 'styles/yui/reset.css']
      FileUtils.touch "#{@name}/.genit"
    end
    
    # Create some subfolders inside the project folder.
    #
    # a_array - An Array of String subfolder names
    #
    # Examples
    #
    #   create_dirs ['styles', 'scripts']
    #
    #   create_dirs ['styles/css/alsa', 'styles/css/yui', 'styles/css/images']
    #
    # Returns nothing.
    def create_dirs a_array
      a_array.each {|dir| FileUtils.makedirs File.join(@name, dir) }
    end
    
    # Copy files to project.
    #
    # a_array - An Array of String "subfolder/file" names
    #
    # Example
    #
    #   copy_files ['templates/main.html', 'pages/index.html']
    #
    # Returns nothing.
    def copy_files a_array
      a_array.each do |file|
        src = File.join $GENIT_PATH, 'data', file
        dest =  File.join @name, file
        FileUtils.cp src, dest
      end
    end
    
    def copy_main_template
      dest =  File.join @name, 'templates', 'main.html'
      copy_first_part dest
      ProjectCreator.append_last_part dest
    end
    
    def copy_first_part dest
      src = File.join $GENIT_PATH, 'data', 'templates', @doctype
      FileUtils.cp src, dest
    end
    
    def self.append_last_part dest
      src = File.join $GENIT_PATH, 'data', 'templates', 'main.html'
      content = File.open(src, "r").read
      File.open(dest, "a") {|out| out.puts content }
    end
    
  end

end