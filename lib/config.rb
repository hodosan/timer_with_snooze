require "i18n"

dir = File.expand_path('..', __FILE__)
I18n.load_path = Dir.glob(File.join(dir, 'locales/*.yml'))

#I18n.locale = :ja
I18n.locale = :en
