module CsvHelpers
  def create_csv_file(content)
    tmp = Tempfile.open(%w[test .csv])
    tmp.write(content)
    tmp.flush
    tmp
  end
end
