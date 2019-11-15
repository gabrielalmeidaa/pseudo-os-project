require_relative '../parsers/process_parser.rb'
require_relative '../parsers/file_system_parser.rb'
require_relative '../models/queue_manager.rb'

module SO
  class Context
    attr_reader :processes
    attr_reader :memory_blocks
    attr_reader :operations

    def initialize(processes_path, files_path)
      @processes = ProcessParser.get_processes(processes_path)
      @unscheduled_processes = @processes.clone.sort_by { |process| process.entry_time }
      file_system = FileSystemParser.parse_files(files_path)
      @operations = file_system[:operations]
      @memory_blocks = build_memory_blocks(file_system)
      @queues = QueueManager.new()
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
    
    def find_block_for_file(size)
      bitmap_memory_string = get_bitmap_memory.join("")
      composed_bitmap = bitmap_memory_string + bitmap_memory_string
      return composed_bitmap.index("000")
    end

    def get_bitmap_memory
      @memory_blocks.map{ |block_index| block_index == nil ? 0 : 1  }
    end

    def create_file(filename, start_index, file_size)
      memory_size = memory_blocks.length
      (start_index... start_index + file_size).each do |index|
        @memory_blocks[index%memory_size] = filename
      end
    end

    def is_file_allocated?(filename)
      @memory_blocks.index(filename) != nil ? true : false
    end

    def delete_file(filename)
      @memory_blocks = @memory_blocks.map{ |block_index| block_index == filename ? nil : block_index}
    end

    def get_next_scheduled_process()
      return @queues.pop
    end
    
    def schedule_processes(time_unit)
      push_arriving_processes(time_unit)
    end

    def push_arriving_processes(time_unit)
      byebug
      arriving_processes = @unscheduled_processes.take_while{|process| process.entry_time == time_unit }
      @unscheduled_processes = @unscheduled_processes - arriving_processes
      arriving_processes.each do |process|
        byebug
        @queues.queue_process(process)
      end
    end

    def activate_preemption?(current_process)
      return false if current_process.priority == 0
      preemptable_process = @queues.next
      if preemptable_process && preemptable_process.priority.to_i < current_process.priority.to_i
        @queue_manager.queue_process(current_process) # Adicionar aging.
        return true
      end
    end
  
    
    def dump_memory
      p memory_blocks
    end

  end
end
