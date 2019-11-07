class Operation
  attr_reader :process_id
  attr_reader :operation_code
  attr_reader :filename
  attr_reader :if_create
  attr_reader :number_process_op

  def initialize(options)
    @process_id = options[:process_id]
    @operation_code = options[:operation_code]
    @filename = options[:filename]
    @if_create = options[:if_create]
    @number_process_op = options[:number_process_op]
  end
end
