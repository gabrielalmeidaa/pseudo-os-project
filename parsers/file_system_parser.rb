require_relative '../models/so_file'
require_relative '../models/operation'

class FileSystemParser
  def self.parse_files(path)
    file = File.open(path)
    lines = File.readlines(file)
    parse_lines(lines)
  ensure
    file.close
  end

  def self.parse_lines(lines)
    total_blocks_occupied = lines[1].to_i

    {
      total_blocks_quantity: lines[0].to_i,
      total_blocks_occupied: total_blocks_occupied,
      so_files: build_blocks(lines, total_blocks_occupied),
      operations: build_operations(lines, total_blocks_occupied)
    }
  end

  def self.build_blocks(lines, total_blocks_occupied)
    blocks_beggining = 2
    blocks_final = total_blocks_occupied + 2

    (blocks_beggining...blocks_final).map do |block_index|
      tokens = lines[block_index].split(',')

      SoFile.new(
        file_name: normalize_token(tokens[0]),
        blocks_occupied: normalize_token(tokens[1]).to_i,
        blocks_quantity: normalize_token(tokens[2]).to_i
      )
    end
  end

  def self.build_operations(lines, total_blocks_occupied)
    blocks_beggining = 2
    operations_beggining = total_blocks_occupied + blocks_beggining

    (operations_beggining...lines.length).map do |operation_index|
      tokens = lines[operation_index].split(',')
      normalize_token(tokens[1]).to_i == 0 ? build_create_operation(tokens) : build_delete_operation(tokens)
    end
  end

  def self.build_create_operation(tokens)
    Operation.new(
      process_id: normalize_token(tokens[0]).to_i,
      operation_code: normalize_token(tokens[1]).to_i,
      filename: normalize_token(tokens[2]).tr(' ', ''),
      if_create: normalize_token(tokens[3]).to_i,
      number_process_op: normalize_token(tokens[4]).to_i
    )
  end

  def self.build_delete_operation(tokens)
    Operation.new(
      process_id: normalize_token(tokens[0]).to_i,
      operation_code: normalize_token(tokens[1]).to_i,
      filename: normalize_token(tokens[2]).tr(' ', ''),
      if_create: nil,
      number_process_op: normalize_token(tokens[3]).to_i
    )
  end

  def self.normalize_token(token)
    token&.tr("\n", '')
  end
end

