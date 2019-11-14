require_relative './so/interpreter'
require 'byebug'

files_path = './samples/files.txt'
processes_path = './samples/processes.txt'
interpreter = Interpreter.new(processes_path, files_path)
interpreter.execute()
