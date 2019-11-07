require './file_parser'
require 'byebug'

byebug
processes = FilesParser.parse_files('files.txt')
byebug