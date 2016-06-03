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
		def generate(name)
			puts "Generating: features/pages/#{name}"
			# class_name, file_name, data_file_name
			Template.shared_template(name, Utility.underscore(name), Utility.unshare(Utility.underscore(name)))
			puts "Generating: features/android/pages/#{Utility.unshare(Utility.underscore(name))}"
			# class_name, file_name, shared_class_name
			Template.android_template(Utility.unshare(name), Utility.unshare(Utility.underscore(name)), name)
			puts "Generating: features/ios/pages/#{Utility.unshare(Utility.underscore(name))}"
			# class_name, file_name, shared_class_name
			Template.ios_template(Utility.unshare(name), Utility.unshare(Utility.underscore(name)), name)
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
	end
end