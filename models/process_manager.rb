
class ProcessManager # I wanted to name this class 'Process', but it seems it is a reserved word
    attr_accessor :process_id, :processing_time, :pc, :entry_time, :priority

    # Returns a process instance based on any line read from the input.txt
    def initialize(id, entry_time, priority, processing_time, block_size, printer_requested, scanner_requested, modem_requested, disk_requested)
        @process_id = id
        @entry_time = entry_time
        @priority = priority
        @processing_time = processing_time
        @block_size = block_size
        @printer_requested = printer_requested
        @scanner_requested = scanner_requested
        @modem_requested = modem_requested
        @disk_requested = disk_requested
        @pc = 0
    end

    def exceeded_processing_time?
        @pc + 1 > @processing_time 
    end

    def increase_priority
        @priority = @priority - 1 if @priority > 1
    end

    def show_process
        puts "dispatcher =>
                pid: #{@process_id},
                priority: #{@priority},
                memory offset: #{@memory_offset},
                reserved memory size: #{@block_size},
                printer used: #{@printer_requested},
                drivers used: [#{@scanner_requested}, #{@modem_requested}, #{@disk_requested}]
            "
    end

end

