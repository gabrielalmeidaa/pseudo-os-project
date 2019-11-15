require './so/so'
require './models/operation'

class Interpreter
    CREATE_OP = 0
    DELETE_OP = 1

    def initialize(processes_path, files_path)
        @operating_system_context = SO::Context.new(processes_path, files_path) 
        @operations = @operating_system_context.operations
        @processes = @operating_system_context.processes
        @operations_by_process = build_operations_by_process(@operations)
        @execution_time_unit = 2
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

        return Operation.create_empty_operation(number_op)
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
        while not program_finished?
            @operating_system_context.schedule_processes(@execution_time_unit)
            current_process = @operating_system_context.get_next_scheduled_process()
            (@execution_time_unit+=1 && @operating_system_context.schedule_processes(@execution_time_unit) && next) if current_process.nil?
            execute_process_operations(current_process)
        end
    end

    def execute_process_operations(current_process)
        current_process.show_process()

        @operations_by_process[current_process.process_id][(current_process.pc)..-1].each do |operation|
            if current_process.exceeded_processing_time?
                operation.print_error_by_exceeded_time(current_process)
                break
            else
                if operation.operation_code == CREATE_OP
                    execute_create_file_operation(current_process, operation)
                else
                    execute_delete_file_operation(current_process, operation)
                end
                current_process.pc += 1
            end
            @execution_time_unit += 1
            @operating_system_context.schedule_processes(@execution_time_unit)
            return if @operating_system_context.activate_preemption?(current_process)
        end
    end

    def execute_create_file_operation(process, operation)
        available_start_block = @operating_system_context.find_block_for_file(operation.if_create)
        if available_start_block
            @operating_system_context.create_file(operation.filename, available_start_block, operation.if_create)
            operation.print_file_created_successfully(process, operation.filename)
        else
            operation.print_error_by_not_enough_blocks(process, operation.filename)
        end
    end

    def execute_delete_file_operation(process, operation)
        if @operating_system_context.is_file_allocated?(operation.filename)
            @operating_system_context.delete_file(operation.filename)
            operation.print_deleted_sucessfully(process, operation.filename)
        else
            operation.print_delete_error_file_not_found(process, operation.filename)
        end
    end

    def program_finished?
        false
    end
 
    def get_next_process
        return find_process_by_id(0)
    end

    def find_process_by_id(id)
        @processes.each do |process|
            return process if process.process_id == id
        end
    end

end