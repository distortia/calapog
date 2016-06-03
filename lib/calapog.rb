require "calapog/version"
# require "calapog/cli"
require 'thor'

module Calapog
	class Main < Thor
		desc "generate SharedClassPage", "This will generate the appropriate Calabash page object pages"
		long_desc <<-GENERATE
		`generate SharedClassPage` scaffolds the 3 seperate pages required for cross platform calabash page object play.\n
		Default directory structure is:\n
		shared_class_page => /features/pages/\n
		class_page => /features/android/pages & /features/ios/pages\n
		GENERATE
		def generate(parent_class)
			child_class = Utility.unshare(parent_class)
			parent_file_name = Utility.underscore(parent_class)
			child_file_name = Utility.unshare(Utility.underscore(parent_class))

			puts "Generating: features/pages/#{parent_file_name}"
			# parent_class, file_name, data_file_name(which is the child file name)
			Template.shared_template(parent_class, parent_file_name, child_file_name)

			puts "Generating: features/android/pages/#{child_file_name}"
			# class_name, file_name, parent_class
			Template.android_template(child_class, child_file_name, parent_class)

			puts "Generating: features/ios/pages/#{child_file_name}"
			# class_name, file_name, parent_class
			Template.ios_template(child_class, child_file_name, parent_class)

			puts "Generating: data/#{child_file_name}"
			# file_name
			Template.yaml_template(child_file_name)
		end
	end

	class Utility
		def self.underscore(camel_cased_word)
			camel_cased_word.to_s.gsub(/::/, '/').
			gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
			gsub(/([a-z\d])([A-Z])/,'\1_\2').
			tr("-", "_").
			downcase
		end

		def self.unshare(name)
			return name.gsub('Shared', '') if name.include? 'Shared'
			return name.gsub('shared_', '') if name.include? 'shared'
		end
	end
	
	class Template
		def self.shared_template(class_name, file_name, data_file_name)
			File.open("features/pages/#{file_name}.rb", "w+") do |file|
				file.write "class #{class_name} < CommonPage\n\n  def trait\n\n  end\n\n  def page_data_file\n    '#{data_file_name}'\n  end\n\n  private\nend"
			end 
		end

		def self.android_template(class_name, file_name, shared_class_name)
			File.open("features/android/pages/#{file_name}.rb", "w+") do |file|
				file.write "class Android::#{class_name} < #{shared_class_name}\n  include Calabash::Android\n\n  private\nend"
			end
		end

		def self.ios_template(class_name, file_name, shared_class_name)
			File.open("features/ios/pages/#{file_name}.rb", "w+") do |file|
				file.write "class IOS::#{class_name} < #{shared_class_name}\n  include Calabash::IOS\n\n  private\nend"
			end
		end

		def self.yaml_template(file_name)
			File.open("data/#{file_name}.yml", "w+") do |file|
				file.write "main_content:"
			end
		end
	end
end