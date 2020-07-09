class IX < Oxidized::Model
  prompt /^([\w.@()-]+[#>]\s?)$/
  comment '! '

  # example how to handle pager
  # expect /^\s--More--\s+.*$/ do |data, re|
  #  send ' '
  #  data.sub re, ''
  # end

  # non-preferred way to handle additional PW prompt
  # expect /^[\w.]+>$/ do |data|
  #  send "enable\n"
  #  send vars(:enable) + "\n"
  #  data
  # end

  cmd :all do |cfg|
    # cfg.gsub! /\cH+\s{8}/, ''         # example how to handle pager
    # cfg.gsub! /\cH+/, ''              # example how to handle pager
    # get rid of errors for commands that don't work on some devices
    cfg.gsub! /^% Invalid input detected at '\^' marker\.$|^\s+\^$/, ''
    cfg.cut_both
  end

  cmd 'show version' do |cfg|
    comment cfg
  end

  cmd 'show running-config' do |cfg|
    cfg
  end

  # cfg :telnet do
  #   username /^Username:/i
  #   password /^Password:/i
  # end

  cfg :telnet, :ssh do
    # preferred way to handle additional passwords
    post_login do
      if vars(:enable) == true
        cmd "enable"
      elsif vars(:enable)
        cmd "enable", /^[pP]assword:/
        cmd vars(:enable)
      end
    end
    post_login 'terminal length 0'
    post_login 'terminal width 0'
    pre_logout 'exit'
  end
end
