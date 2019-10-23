require_relative './models/process_manager'

def read_processes(filename)
    processes = []
    file = File.open(filename)
    lines = file.read.split("\n")
    id = 0

    for line in lines do         
        processes.push(ProcessManager.new(line,id))
        id += 1
    end
    return processes
end


processes = read_processes('processes.txt')