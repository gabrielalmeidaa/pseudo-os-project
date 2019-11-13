class ResourceManager
  def initialize
    @scanner_usage = { process_owner: nil }
    @printer_usage = { process_owner: nil }
    @modem_usage = { process_owner: nil }
    @drivers_usage = { process_owner: nil }
  end

  def request_scanner(process_id)
    return p "Scanner in use by process #{process_id}" if @scanner_usage[:process_owner] != nil

    @scanner_usage[:process_owner] = process_id
  end

  def release_scanner
    @scanner_usage[:process_owner] = nil
  end

  def request_printer(process_id)
    return p "Printer in use by process #{process_id}" if @printer_usage[:process_owner] != nil

    @printer_usage[:process_owner] = process_id
  end

  def release_printer
    @printer_usage[:process_owner] = nil
  end

  def request_modem(process_id)
    return p "Modem in use by process #{process_id}" if @modem_usage[:process_owner] != nil

    @modem_usage[:process_owner] = process_id
  end

  def release_modem
    @modem_usage[:process_owner] = nil
  end

  def request_driver(process_id)
    return p "Scanner in use by process #{process_id}" if @drivers_usage[:process_owner] != nil

    @drivers_usage[:process_owner] = process_id
  end

  def release_driver
    @drivers_usage[:process_owner] = nil
  end



end
