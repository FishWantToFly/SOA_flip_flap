require 'yaml'
# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    lines = tsv.split("\n")
    keys = lines[0].split("\t")
    keys.map!(&:chomp)
    lines.shift
    @data = deal_lines(keys, lines)
  end

  def deal_lines(keys, lines)
    yaml_array = []
    lines.each do |line|
      values = line.split("\t")
      record_this_line = {}
      keys.each_index do |index|
        record_this_line[keys[index]] = values[index].chomp
      end
      yaml_array.push(record_this_line)
    end
    yaml_array
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    key_list = []
    @data[0].each_key { |key| key_list << key }
    key_line = ''
    key_list.each_with_index do |key, index|
      key_line.concat(key)
      key_line.concat("\t") if index != key_list.size - 1
    end
    deal_record_this_line(key_line)
  end

  def deal_record_this_line(key_line)
    output = ''
    output << key_line << "\n"
    @data.each do |record_this_line|
      record_this_line.each_with_index do |(_, value), index|
        output << value
        output << "\t" if index != record_this_line.size - 1
      end
      output << "\n"
    end
    output
  end
end
