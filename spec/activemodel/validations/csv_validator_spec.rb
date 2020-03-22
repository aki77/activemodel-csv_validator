require 'tempfile'

RSpec.describe ActiveModel::Validations::CsvValidator do
  let(:model_class) do
    _options = options

    Struct.new(:file) do
      include ActiveModel::Validations
      validates :file, presence: true, csv: _options

      def self.name
        'DummyModel'
      end
    end
  end
  let(:model) { model_class.new(csv_file) }

  describe 'validate' do
    context 'valid file' do
      let(:csv_file) do
        create_csv_file(<<~CSV)
          field1,field2,field3
          aaa,iii,uuu
        CSV
      end
      let(:options) { true }

      it 'Pass validation' do
        expect(model.valid?).to eq true
      end
    end

    context 'When the CSV format is invalid' do
      let(:csv_file) do
        create_csv_file(<<~CSV)
          field1,field2,field3
          "3",NAME"","VAL
        CSV
      end
      let(:options) { true }

      it 'invalid_csv error' do
        model.valid?
        expect(model.errors).to be_of_kind(:file, :invalid_csv)
      end
    end

    context 'When the number of lines is exceeded' do
      let(:csv_file) do
        create_csv_file(<<~CSV)
          field1,field2,field3
          aaa,iii,uuu
          aaa,iii,uuu
        CSV
      end
      let(:options) { { max: 1 } }

      it 'max_rows error' do
        model.valid?
        expect(model.errors).to be_of_kind(:file, :max_rows)
      end
    end

    context 'When headers are different' do
      let(:csv_file) do
        create_csv_file(<<~CSV)
          field1,field2,field4
          aaa,iii,uuu
        CSV
      end
      let(:options) { { headers: %w[field1 field2 field3] } }

      it 'missing_headers error' do
        model.valid?
        expect(model.errors).to be_of_kind(:file, :missing_headers)
      end
    end

    context 'When the file is nil' do
      let(:csv_file) { nil }
      let(:options) { true }

      it 'blank error' do
        model.valid?
        expect(model.errors).to be_of_kind(:file, :blank)
      end
    end
  end
end
