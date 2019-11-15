class Operation
  attr_reader :process_id
  attr_reader :operation_code
  attr_reader :filename
  attr_reader :if_create
  attr_reader :number_process_op

  def initialize(options, empty=false)
    @process_id = options[:process_id]
    @operation_code = options[:operation_code]
    @filename = options[:filename]
    @if_create = options[:if_create]
    @number_process_op = options[:number_process_op]
    @empty= empty
  end

  def self.create_empty_operation(number_process_op)
    Operation.new({number_process_op: number_process_op}, empty= true)
  end

  def print_information(process, time_unit)
    if time_unit > process.processing_time
      print_error_by_exceeded_time(process)
    else
      if @empty
        print_operation_details(process)
      end
    end
  end

  def print_operation_details(process)
    puts "P#{process.process_id} instruction #{@number_process_op} - SUCESSO CPU"
  end

  def print_error_by_exceeded_time(process)
    puts "P#{process.process_id} instruction #{@number_process_op} - FALHA
      O processo #{process.process_id} esgotou o seu tempo de CPU!"
  end

  def print_file_created_successfully(process, filename)
    puts "P#{process.process_id} instruction #{@number_process_op} - SUCESSO
      O processo #{process.process_id} criou o arquivo #{filename} com sucesso!" 
  end

  def print_error_by_not_enough_blocks(process, filename)
    puts "P#{process.process_id} instruction #{@number_process_op} - FALHA
      O processo #{process.process_id} não pode criar o arquivo #{filename} por falta de espaço!" 
  end

  def print_delete_error_file_not_found(process, filename)
    puts "P#{process.process_id} instruction #{@number_process_op} - FALHA
      O processo #{process.process_id} não pode deletar o arquivo #{filename} pois ele não foi encontrado!" 
  end

  def print_deleted_successfully(process, filename)
    puts "P#{process.process_id} instruction #{@number_process_op} - SUCESSO
      O processo #{process.process_id} deletou o arquivo #{filename} com sucesso!" 
  end

end
