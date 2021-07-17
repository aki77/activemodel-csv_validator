require 'active_model'
require 'csv'
require 'nkf'

module ActiveModel
  module Validations
    class CsvValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        return if value.nil?

        content = NKF.nkf('-w', File.read(value.path, universal_newline: true))
        rows = CSV.parse(content, headers: :first_row, converters: :integer)

        if options[:max].present? && rows.size > options[:max]
          record.errors.add(attribute, :max_rows, **options.slice(:max).merge(rows: rows.size))
        end

        if options[:headers].present?
          missing_headers = options[:headers] - rows.headers
          if missing_headers.present?
            record.errors.add(attribute, :missing_headers, missing_headers: missing_headers.to_sentence)
          end
        end
      rescue CSV::MalformedCSVError
        record.errors.add(attribute, :invalid_csv)
      end
    end
  end
end
