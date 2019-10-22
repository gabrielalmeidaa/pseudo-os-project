class ResourceManager
  AVAILABLE = 'available'
  DISABLED = 'disabled'

    def initialize
        @scanner = AVAILABLE
        @printer_1 = AVAILABLE
        @printer_2 = AVAILABLE
        @modem = AVAILABLE
        @sata_1 = AVAILABLE
        @sata_2 = AVAILABLE
    end
end
