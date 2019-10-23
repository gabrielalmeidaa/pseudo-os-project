class FilesParser
  def self.parse_files(path)
    file = File.open(path)
    lines = File.readlines(file)
    parse_lines(lines)
  ensure
    file.close
  end

  def self.parse_lines(lines)
    total_blocks_occupied = lines[1].to_i
    p build_operations(lines, total_blocks_occupied)

    {
      total_blocks_quantity: lines[0].to_i,
      total_blocks_occupied: total_blocks_occupied,
      blocks: build_blocks(lines, total_blocks_occupied),
      operations: build_operations(lines, total_blocks_occupied)
    }
  end

  def self.build_blocks(lines, total_blocks_occupied)
    blocks_beggining = 2
    blocks_final = total_blocks_occupied + 2

    (blocks_beggining...blocks_final).map do |block_index|
      tokens = lines[block_index].split(',')

      {
        file_name: normalize_token(tokens[0]),
        blocks_occupied: normalize_token(tokens[1]).to_i,
        blocks_quantity: normalize_token(tokens[2]).to_i
      }
    end
  end

  def self.build_operations(lines, total_blocks_occupied)
    operations_beggining = total_blocks_occupied + 3

    (operations_beggining...lines.length).map do |operation_index|
      tokens = lines[operation_index].split(',')

      {
        process_id: normalize_token(tokens[0]).to_i,
        operation_code: normalize_token(tokens[1]).to_i,
        filename: normalize_token(tokens[2]),
        if_create: normalize_token(tokens[3]).to_i,
        number_process_op: normalize_token(tokens[4]).to_i
      }
    end
  end

  def self.normalize_token(token)
    token&.tr("\n", '')
  end
end

FilesParser.parse_files('./files.txt')
