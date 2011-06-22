require 'crontab_fields'

class CrontabLine
  @@ENTRY_REGEX = /^([-\/,0-9*]+)\s+([-\/,0-9*]+)\s+([-\/,0-9*]+)\s+([-\/,0-9*]+)\s+([-\/,0-9*]+)\s+(.*)$/
  @@MINUTE_GROUP_NUM = 1
  @@HOUR_GROUP_NUM = 2
  @@DAY_GROUP_NUM = 3
  @@MONTH_GROUP_NUM = 4
  @@WEEKDAY_GROUP_NUM = 5
  @@COMMAND_GROUP_NUM = 6
  @@SPACE_IN_LIST_REGEX = /\d+(-\d+(\/\d+)?)?,\s\d+/
  def initialize
    @minute = [CrontabAsterisk.new]
    @hour = [CrontabAsterisk.new]
    @day = [CrontabAsterisk.new]
    @month = [CrontabAsterisk.new]
    @weekday = [CrontabAsterisk.new]
    @command = ""
    @user = nil
  end
  attr_accessor :user
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
        crontab.send("#{key}=", value)
    end
    crontab
  end
  def self.create_by_entry(entry)
    md = @@SPACE_IN_LIST_REGEX.match(entry)
    if md
      raise "I think you have a space in a crontab field (but I'm not very smart).  " +
           "Use 'create_by_hash()' instead to override me."
    end
    md = @@ENTRY_REGEX.match(entry) 
    if md
      crontab = CrontabLine.new
      crontab.minute = md[@@MINUTE_GROUP_NUM]
      crontab.hour = md[@@HOUR_GROUP_NUM]
      crontab.day = md[@@DAY_GROUP_NUM]
      crontab.month = md[@@MONTH_GROUP_NUM]
      crontab.weekday = md[@@WEEKDAY_GROUP_NUM]
      crontab.command = md[@@COMMAND_GROUP_NUM]
      crontab
    else
      raise "Entry did match expected pattern"
    end
  end
  def to_s
    fields = [minute, hour, day, month, weekday, command]
    fields.insert(-2, user) unless user.nil?
    fields.join(" ")
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
    raise "Crontab fields may not contain white-space characters" if value =~ /\s/
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

def verify_crontab_line(crontab_line)
  begin
    CrontabLine.create_by_entry(crontab_line).to_s
  rescue RuntimeError => e
    raise "Invalid entry \"#{crontab_line}\": #{e.message}"
  end
end

def verify_crontab_hash(crontab_hash)
  begin
    CrontabLine.create_by_hash(crontab_hash).to_s
  rescue RuntimeError => e
    raise "Invalid entry \"#{crontab_hash.inspect}\": #{e.message}"
  end
end