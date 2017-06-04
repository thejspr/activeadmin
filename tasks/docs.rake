namespace :docs do

  def filename_from_module(mod)
    mod.name.to_s.underscore.tr('_', '-')
  end

  def write_docstrings_to(path, mods)
    mods.each do |mod|
      File.open("#{path}/#{filename_from_module(mod)}.md", 'w+') do |f|
        f << mod.docstring + "\n"
      end
    end
  end

  desc "Update docs in the docs folder"
  task :build do
    require 'yard'
    require 'active_support/all'

    YARD::Registry.load!
    views = YARD::Registry.at("ActiveAdmin::Views")

    # Index Types
    index_types = views.children.select{|obj| obj.name.to_s =~ /^IndexAs/ }
    write_docstrings_to "docs/3-index-pages", index_types
  end

end
