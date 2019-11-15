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

    def queue_process(process)
        return false if get_current_number_of_processes >= @maximum_number_of_processes 
        case process.priority
        when 0
            @real_time_queue << process
        when 1
            @user_process_queue[:high] << process
        when 2
            @user_process_queue[:medium] << process
        when 3
            @user_process_queue[:low] << process
        end
        return true
    end

    def pop
        return @real_time_queue.shift             unless @real_time_queue.empty?
        return @user_process_queue[:high].shift   unless @user_process_queue[:high].empty?
        return @user_process_queue[:medium].shift unless @user_process_queue[:medium].empty?
        return @user_process_queue[:low].shift    unless @user_process_queue[:low].empty?
    end

    def next
        return @real_time_queue.first             if @real_time_queue.empty?
        return @user_process_queue[:high].first   if @user_process_queue[:high].empty?
        return @user_process_queue[:medium].first if @user_process_queue[:medium].empty?
        return @user_process_queue[:low].first    if @user_process_queue[:low].empty?
    end
end
