require "activemodel/csv_validator/version"
require 'activemodel/validations/csv_validator'

module Activemodel
  module CsvValidator
  end
end

I18n.load_path += Dir[File.expand_path(File.join(__dir__, '../../config/locales', '*.yml')).to_s]
