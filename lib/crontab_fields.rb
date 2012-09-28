
class AbstractCrontabField
  @@CRONTAB_FIELD_REGEX = /^(\*|(\d)+)(-(\d+))?(\/(\d+))?$/
  @@START_GROUP_NUM = 1
  @@STOP_GROUP_NUM = 4
  @@STEP_GROUP_NUM = 6
  @@ASTERISK_FIELD_REGEX = /^\*(\/(\d+))?$/
  def initialize(start, stop=nil, step=nil)
    @start = start.to_i
    @stop = stop.nil? ? @start : stop.to_i
    @step = step.nil? ? 1 : step.to_i
    if @step > 1 and @stop == @start
      raise "Stepping must be used with ranges or asterisk only"
    end
  end
  def self.create_from_string(field_string)
    md = @@CRONTAB_FIELD_REGEX.match(field_string)
    if md
      asterisk_md = @@ASTERISK_FIELD_REGEX.match(md[@@START_GROUP_NUM])
      if asterisk_md
        step = md[@@STEP_GROUP_NUM]
        CrontabAsterisk.new(step)
      else
        start = md[@@START_GROUP_NUM]
        stop = md[@@STOP_GROUP_NUM]
        step = md[@@STEP_GROUP_NUM]
        new(start, stop, step)
      end
    else
      raise "Can't parse crontab field \"#{field_string}\""
    end
  end
  def to_s
    as_s = @start.to_s
    as_s += "-#{@stop}" if @stop > @start
    as_s += "/#{@step}" if @step > 1
    as_s
  end
end

class CrontabAsterisk < AbstractCrontabField
  def initialize(step=nil)
    step.nil? ? @step = 1 : @step = step.to_i
  end
  def to_s
    as_s = '*'
    as_s += "/#{@step}" if @step > 1
    as_s
  end
end

class CrontabMinute < AbstractCrontabField
  @@min = 0
  @@max = 59
  def initialize(start, stop=nil, step=nil)
    super(start, stop, step)
    raise "Minute field #{@start} must not be greater than #{@@min}" if @start < @@min
    raise "Minute field #{@stop} must not be greater than #{@@max}" if @stop > @@max
  end
end

class CrontabHour < AbstractCrontabField
  @@min = 0
  @@max = 23
  def initialize(start, stop=nil, step=nil)
    super(start, stop, step)
    raise "Hour field #{@start} must not be greater than #{@@min}" if @start < @@min
    raise "Hour field #{@stop} must not be greater than #{@@max}" if @stop > @@max
  end
end

class CrontabDay < AbstractCrontabField
  @@min = 1
  @@max = 31
  def initialize(start, stop=nil, step=nil)
    super(start, stop, step)
    raise "Day field #{@start} must not be greater than #{@@min}" if @start < @@min
    raise "Day field #{@stop} must not be greater than #{@@max}" if @stop > @@max
  end
end

class CrontabMonth < AbstractCrontabField
  @@min = 1
  @@max = 12
  def initialize(start, stop=nil, step=nil)
    super(start, stop, step)
    raise "Month field #{@start} must not be greater than #{@@min}" if @start < @@min
    raise "Month field #{@stop} must not be greater than #{@@max}" if @stop > @@max
  end
end

class CrontabWeekday < AbstractCrontabField
  @@min = 0
  @@max = 7
  def initialize(start, stop=nil, step=nil)
    super(start, stop, step)
    raise "Weekday field #{@start} must not be greater than #{@@min}" if @start < @@min
    raise "Weekday field #{@stop} must not be greater than #{@@max}" if @stop > @@max
  end
end