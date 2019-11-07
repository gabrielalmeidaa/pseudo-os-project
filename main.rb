require_relative './so/so'
require_relative './so/interpreter'
require 'byebug'

context_path = './samples/context.txt'
CONTEXT = SO::Context.new(context_path)
interpreter = Interpreter.new(CONTEXT.operations, CONTEXT.processes)

