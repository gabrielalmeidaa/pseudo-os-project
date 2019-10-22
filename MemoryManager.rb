class MemoryManager
    def initialize
        @total_memory_size = 1024
        @real_time_available_blocks = 64
        @user_process_available_blocks = 960
    end

    def get_current_available_memory
        return @real_time_available_blocks + @user_process_available_blocks
    end


end
