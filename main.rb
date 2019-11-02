require_relative './so/so'

processes_file_path = './samples/files.txt'
files_file_path = './samples/processes.txt'

CONTEXT = SO::Context.new(processes_file_path, files_file_path)
