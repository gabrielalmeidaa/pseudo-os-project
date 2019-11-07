require './models/process_manager'
require 'byebug'

class ProcessParser

    def self.get_processes(path)
        processes = []
        file = File.open(path)
        lines = File.readlines(file)
        lines.each_with_index do |line, index|
            processes.push(parse_process(index, line))
        end

        return processes
    end

    def self.find_process(pid)
        processes = get_processes('processes.txt')
        for process in processes do
            if process.process_id == pid
                return process
            end
        end
        
        return nil
    end

    def self.parse_process(id, line)
        tokens = line.split(",")
        entry_time = tokens[0]
        priority = tokens[1]
        processing_time = tokens[2]
        block_size = tokens[3]
        printer_requested = tokens[4]
        scanner_requested = tokens[5]
        modem_requested = tokens[6]
        disk_requested = tokens[7]
        
        return ProcessManager.new(id, entry_time, priority, processing_time.to_i, block_size, printer_requested, scanner_requested, modem_requested, disk_requested)
    end
end