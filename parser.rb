require 'json'

class Parser
  IGNORED_HEADERS = ['Value','Source','Application']
  IGNORED_VALUES = ['Name','Source','Application']

  def initialize(filename)
    @filename = filename
    @headers = ''
    @values = ''
  end

  def parse
    content = JSON.parse(file)
    headers = build_header(content["Devices"])
    rows = compose_rows(content["Devices"])
    generate_csv(headers, rows)
  end

  private

  def build_header(content)
    content.first.each do |key, value|
      extract_header_fields(key,value)
    end
    @headers
  end

  def extract_header_fields(key,value)
    if value.class == Array
      add_header_from(value)
    elsif value.class == Hash
      build_header(value)
    else
      @headers += "#{normalize(key)},"
    end
  end

  def add_header_from(values)
    values.each do |element|
      element.each do |key, value|
        if key == 'Name'
          @headers += "#{normalize(value)},"
        elsif IGNORED_HEADERS.include?(key)
          @headers
        else
          @headers = extract_header_fields(key,value)
        end
      end
    end
  end

  def compose_rows(content)
    rows = ''
    content.each do |item|
      rows += (extract_hash_values_from(item).chomp(',') + "\n")
    end
    rows
  end

  def extract_hash_values_from(item)
    @values = ''
    item.each do |key, value|
      if value.class == Array
        extract_array_values_from(value)
      elsif value.class == Hash
        extract_hash_values_from(value)
      else
        @values += "#{normalize(value)},"
      end
    end
    @values
  end

  def extract_array_values_from(item)
    item.each do |element|
      element.each do |key, value|
        if value.class == Array
        extract_array_values_from(value)
        elsif IGNORED_VALUES.include?(key)
          @values
        else
          @values += "#{normalize(value)},"
        end
      end
    end
    @values
  end

  def normalize(value)
    value.to_s.gsub(',', ' -')
  end

  def generate_csv(headers, rows)
    csv_file = headers.chomp(',') + "\n" + rows
    File.write('result.csv', csv_file)
    csv_file
  end

  def file
    read(@filename)
  end

  def read(filename)
    path = File.join(File.dirname(__FILE__), filename)
    File.read(path)
  end
end
