require 'crontab_fields'

class CrontabLine
  @@entry_regex = /^([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+([,0-9*]+)\s+(.*)$/
  @@crontab_null_singleton = CrontabNullField.new
  def initialize
    @minute = [@@crontab_null_singleton]
    @hour = [@@crontab_null_singleton]
    @day = [@@crontab_null_singleton]
    @month = [@@crontab_null_singleton]
    @weekday = [@@crontab_null_singleton]
    @command = ""
  end
  def minute
    @minute.join(',')
  end
  def minute=(value)
    if value =~ /\*/
      @minute = [@@crontab_null_singleton]
    else
      value = value.to_s unless value.instance_of? String
      minute_strings = value.split(',')
      @minute = minute_strings.map {|min_s| CrontabMinute.create_from_string(min_s)}
    end
  end
  def hour
    @hour.join(',')
  end
  def hour=(value)
    if value =~ /\*/
      @hour = [@@crontab_null_singleton]
    else
      value = value.to_s unless value.instance_of? String
      hour_strings = value.split(',')
      @hour = hour_strings.map {|hou_s| CrontabHour.create_from_string(hou_s)}
    end
  end
  def day
    @day.join(',')
  end
  def day=(value)
    if value =~ /\*/
      @day = [@@crontab_null_singleton]
    else
      value = value.to_s unless value.instance_of? String
      day_strings = value.split(',')
      @day = day_strings.map {|day_s| CrontabDay.create_from_string(day_s)}
    end
  end
  def month
    @month.join(',')
  end
  def month=(value)
    if value =~ /\*/
      @month = [@@crontab_null_singleton]
    else
      value = value.to_s unless value.instance_of? String
      month_strings = value.split(',')
      @month = month_strings.map {|mon_s| CrontabMonth.create_from_string(mon_s)}
    end
  end
  def weekday
    @weekday.join(',')
  end
  def weekday=(value)
    if value =~ /\*/
      @weekday = [@@crontab_null_singleton]
    else
      value = value.to_s unless value.instance_of? String
      weekday_strings = value.split(',')
      @weekday = weekday_strings.map {|wkd_s| CrontabWeekday.create_from_string(wkd_s)}
    end
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
end