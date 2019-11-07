require './file_parser'
require './process_parser'
require 'byebug'

def get_instructions
    file_structure = FilesParser.parse_files('files.txt')
    operations = set_up_operations(file_structure[:operations])
    for operation in file_structure[:operations] do
        show_operation_description(operation)
    end
end

def set_up_operations(operations)
        operations = group_operations_by_process(operations)
    for process_id in operations.keys do
        process = ProcessParser.find_process(process_id)
        group_operation_by_batch(operations[process_id], process.processing_time)
    end
end

def group_operation_by_batch(operations, processing_time)
  byebug
  operations = operations.sort_by { |key| key[:operation_code] }

end

def group_operations_by_process(operations)
    grouped_data = {}
    for operation in operations do
        if not grouped_data.key?(operation[:process_id])
            grouped_data[operation[:process_id]] = []
        end    
        grouped_data[operation[:process_id]].push(operation)
    end
    return grouped_data
end


def show_operation_description(operation)
    puts "O processo #{operation[:operation_code]}"
end

get_instructions()