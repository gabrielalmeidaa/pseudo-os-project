class ProcessManager # I wanted to name this class 'Process', but it seems it is a reserved word
    # Returns a process instance based on any line read from the input.txt
    def initialize(line, id)
        tokens = line.split(',')
        @process_id = id
        @entry_time = tokens[0]
        @priority = tokens[1]
        @block_size = tokens[3]
        @printer_requested = tokens[4]
        @scanner_requested = tokens[5]
        @modem_requested = tokens[6]
        @disk_requested = tokens[7]

        @memory_offset = "?????" # I actually don't know what that's supposed to be
    end

    def show_process
        puts "dispatcher =>\n
                pid: #{@process_id},\n
                priority: #{@priority},\n
                memory offset: #{@memory_offset},\n
                reserved memory size: #{@block_size},\n
                printer used: #{@printer_requested},
                drivers used: ...\n
            "
    end

end

