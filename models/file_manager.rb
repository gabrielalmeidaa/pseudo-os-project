class FileManager
    
    def initialize(line)
        tokens = line.split(',')
        @process_id = tokens[0]
        @operation_code = tokens[1]
        @filename = tokens[2]
        @if_create = tokens[3]
        @number_process_op = tokens[4]
        
    end
    
end