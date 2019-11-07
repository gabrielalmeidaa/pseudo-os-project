require_relative '../parsers/process_parser.rb'
require_relative '../parsers/file_system_parser.rb'

module SO
  class Context
    attr_reader :processes
    attr_reader :memory_blocks

    def initialize(context_path)
      @processes = ProcessParser.get_processes(context_path)
      file_system = FileSystemParser.parse_files(context_path)
      @memory_blocks = build_memory_blocks(file_system)
    end

    private def build_memory_blocks(file_system)
      blank_memory = Array.new(file_system[:total_blocks_quantity])
      occupy_memory(blank_memory, file_system[:so_files])
    end

    private def occupy_memory(memory, so_files)
      so_files.each do |so_file|
        first_block_occupied = so_file.blocks_occupied
        blocks_quantity = so_file.blocks_quantity

        (1..blocks_quantity).each do |i|
          memory[first_block_occupied] = so_file.file_name
          first_block_occupied += i
        end
      end

      memory
    end

    def dump_memory
      p memory_blocks
    end
  end
end
