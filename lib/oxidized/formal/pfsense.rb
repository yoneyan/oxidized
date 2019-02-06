class PfSense
  def formalise(outputs)
    cfg = outputs.to_cfg

    cfg.match(/<pfsense>\s*<version>([0-9.]+)<\/version>/) do
      formal.firmware_version = Regexp.last_match(1)
    end
  end
end
