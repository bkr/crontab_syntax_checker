require 'crontab_fields'

class CrontabLine
  @@entry_regex = /^([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+(.*)$/
  def initialize
    @minute = [CrontabAsterisk.new]
    @hour = [CrontabAsterisk.new]
    @day = [CrontabAsterisk.new]
    @month = [CrontabAsterisk.new]
    @weekday = [CrontabAsterisk.new]
    @command = ""
  end
  def minute
    @minute.join(',')
  end
  def minute=(value)
    param_setter(:@minute, value)
  end
  def hour
    @hour.join(',')
  end
  def hour=(value)
    param_setter(:@hour, value)
  end
  def day
    @day.join(',')
  end
  def day=(value)
    param_setter(:@day, value)
  end
  def month
    @month.join(',')
  end
  def month=(value)
    param_setter(:@month, value)
  end
  def weekday
    @weekday.join(',')
  end
  def weekday=(value)
    param_setter(:@weekday, value)
  end
  attr_reader :command
  def command=(value)
    value = "" if value.nil?
    value = value.to_s unless value.instance_of?(String)
    @command = value
  end
  def self.create_by_hash(crontab_hash)
    crontab = CrontabLine.new
    crontab_hash.each() do |key, value|
        crontab.public_send(key, value)
    end
    crontab
  end
  def self.create_by_entry(entry)
    md = @@entry_regex.match(entry) 
    if md
      crontab = CrontabLine.new
      crontab.minute = md[1]
      crontab.hour = md[2]
      crontab.day = md[3]
      crontab.month = md[4]
      crontab.weekday = md[5]
      crontab.command = md[7]
      crontab
    else
      raise error_message(entry, "Entry did match expected pattern")
    end
  end
  def to_s
    [minute, hour, day, month, weekday, @command].join(" ") + "\n"
  end
  private
  @@FIELD_CLASS_BY_PARAM = {
    :@minute => CrontabMinute,
    :@hour => CrontabHour,
    :@day => CrontabDay,
    :@month => CrontabMonth,
    :@weekday => CrontabWeekday
  }
  def get_field_class(param)
    @@FIELD_CLASS_BY_PARAM[param]
  end
  def param_setter(param, value)
    value = "*" if value.nil?
    value = value.to_s unless value.instance_of? String
    if value =~ /\*(,|$)/
      instance_variable_set(param, [CrontabAsterisk.new])
    else
      minute_strings = value.split(',')
      instance_variable_set(param, minute_strings.map {|min_s| (get_field_class(param)).create_from_string(min_s)})
    end
  end
end