require './so/so'

class Interpreter
    def initialize(path)
        @operating_system_context = SO::Context.new(path) 
        @operations = @operating_system_context.operations
        @processes = @operating_system_context.processes
        @operations_by_process = build_operations_by_process(@operations)
    end

    def build_operations_by_process(operations)
        operations_by_process = {}
        operations = group_operations_by_process(operations)
        for process_id in operations.keys do
            process_operations = group_operation_by_batch(operations[process_id])
            operations_by_process[process_id] = process_operations
        end
        return operations_by_process
    end

    def group_operation_by_batch(operations)
        batch = []
        operations = operations.sort_by {|operation| operation.number_process_op}
        (0..operations.last.number_process_op).each do |idx|
            batch.append(find_operation_by_process_op(operations, idx))
        end

        return batch
    end

    def find_operation_by_process_op(operations, number_op)
        operations.each do |operation|
            return operation if operation.number_process_op == number_op
        end
        return nil
    end

    def group_operations_by_process(operations)
        grouped_data = {}
        for operation in operations do
            if not grouped_data.key?(operation.process_id)
                grouped_data[operation.process_id] = []
            end    
            grouped_data[operation.process_id].push(operation)
        end
        return grouped_data
    end

    def execute()
        p "To be implemented."
    end
end