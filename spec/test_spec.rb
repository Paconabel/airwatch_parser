require 'rspec'
require_relative '../parser'

describe 'JSON parse' do
  it 'returns a csv' do
    result = Parser.new(file).parse
    expect(result).to eq(result_csv)
  end

  def file
    'spec/fixture/test.json'
  end

  def result_csv
    read('fixture/result.csv')
  end

  def read(filename)
    path = File.join(File.dirname(__FILE__), filename)
    File.read(path)
  end
end



