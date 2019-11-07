class SoFile
  attr_reader :file_name
  attr_reader :blocks_occupied
  attr_reader :blocks_quantity

  def initialize(options)
    @file_name = options[:file_name]
    @blocks_occupied = options[:blocks_occupied]
    @blocks_quantity = options[:blocks_quantity]
  end
end
