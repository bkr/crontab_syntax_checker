
class AbstractCrontabField
  @@CRONTAB_FIELD_REGEX = /^(\*|(\d)+)(-(\d+)(\/(\d+))?)?$/
  def initialize(start, stop=nil, step=nil)
    @start = start.to_i
    stop.nil? ? @stop = @start : @stop = stop.to_i
    step.nil? ? @step = 1 : @step = step.to_i
  end
  def self.create_from_string(field_string)
    md = @@CRONTAB_FIELD_REGEX.match(field_string)
    if md
      if md[1] == '*'
        CrontabNullField.new
      else
        start = md[1]
        stop = md[4]
        step = md[6]
        new(start, stop, step)
      end
    else
      raise "Can't create CrontabMinute from \"#{field_string}\""
    end
  end
  def to_s
    as_s = @start.to_s
    as_s += "-#{@stop}" if @stop > @start
    as_s += "/#{@step}" if @step > 1
    as_s
  end
end

class CrontabNullField < AbstractCrontabField
  def initialize
  end
  def to_s
    '*'
  end
end

class CrontabMinute < AbstractCrontabField
  @@min = 0
  @@max = 59
end

class CrontabHour < AbstractCrontabField
  @@min = 0
  @@max = 23
end

class CrontabDay < AbstractCrontabField
  @@min = 1
  @@max = 31
end

class CrontabMonth < AbstractCrontabField
  @@min = 1
  @@max = 12
end

class CrontabWeekday < AbstractCrontabField
  @@min = 0
  @@max = 7
end