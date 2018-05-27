require "i18n"

dir = File.expand_path('..', __FILE__)
local_files = Dir.glob(File.join(dir, 'locales/*.yml'))
I18n.load_path = local_files


#I18n.locale = :ja
I18n.locale = :en
