require_relative './so/interpreter'
require 'byebug'

files_path = './samples/files.txt'
interpreter = Interpreter.new(files_path)

