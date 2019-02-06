class Comware
  def formalise(outputs)
    cfg = outputs.to_cfg

    cfg.match(/# (3Com Corporation)/) do
      formal.manufacturer = Regexp.last_match(1)
    end

    cfg.match(/# (Switch .+?) Software Version 3Com OS (V[0-9.a-z]+)/) do
      formal.name = Regexp.last_match(1)
      formal.firmware_version = Regexp.last_match(2)
    end

    cfg.match(/Switch .+? 48-Port with ([0-9]+) Processor/) do
      formal.cores = Regexp.last_match(1).to_i
    end

    cfg.match(/# ([0-9]+)M   bytes DRAM/) do
      formal.ram = Regexp.last_match(1).to_i * 1024 * 1024
    end

    cfg.match(/# ([0-9]+)M   bytes Flash Memory/) do
      formal.nvmem = Regexp.last_match(1).to_i * 1024 * 1024
    end
  end
end
