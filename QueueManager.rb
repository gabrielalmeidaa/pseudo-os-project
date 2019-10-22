class QueueManager

    def initialize
        @maximum_number_of_processes = 1000
        @real_time_queue = []
        @user_process_queue = {high: [], medium: [], low: []} 
    end
   

    def get_current_number_of_processes
        user_process_queue_length = @user_process_queue[:high].length + @user_process_queue[:medium].length + @user_process_queue[:low].length
        return @real_time_queue.length + user_process_queue_length
    end

end

q = QueueManager.new
puts(q)
puts(q.get_current_number_of_processes())