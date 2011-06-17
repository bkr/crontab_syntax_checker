require 'test/unit'
require 'crontab_syntax_checker'

class TestCrontabLineGetters < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_default_minute
    assert_equal '*', @crontab.minute, "Default minute is wrong"
  end
  def test_default_hour
    assert_equal '*', @crontab.hour, "Default hour is wrong"
  end
  def test_default_day
    assert_equal '*', @crontab.day, "Default day is wrong"
  end
  def test_default_month
    assert_equal '*', @crontab.month, "Default month is wrong"
  end
  def test_default_weekday
    assert_equal '*', @crontab.weekday, "Default weekday is wrong"
  end
  def test_default_command
    assert_equal '', @crontab.command, "Default command is wrong"
  end
end

class TestCrontabLineSetters < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_set_minute_to_1
    @crontab.minute = "1"
    assert_equal "1", @crontab.minute, "The minute value was incorrect"
  end
  def test_set_minute_to_1_by_int
    @crontab.minute = 1
    assert_equal "1", @crontab.minute, "The minute value was incorrect"
  end
  def test_set_minute_to_1_2_3
    set_to = "1,2,3"
    @crontab.minute = set_to
    assert_equal set_to, @crontab.minute, "The minute value was incorrect"
  end
  def test_set_minute_to_nil
    @crontab.minute = nil
    assert_equal '*', @crontab.minute, "The minute value was incorrect"
  end
  def test_set_hour_to_1
    @crontab.hour = "1"
    assert_equal "1", @crontab.hour, "The hour value was incorrect"
  end
  def test_set_hour_to_1_by_int
    @crontab.hour = 1
    assert_equal "1", @crontab.hour, "The hour value was incorrect"
  end
  def test_set_hour_to_1_2_3
    set_to = "1,2,3"
    @crontab.hour = set_to
    assert_equal set_to, @crontab.hour, "The hour value was incorrect"
  end
  def test_set_hour_to_nil
    @crontab.hour = nil
    assert_equal '*', @crontab.hour, "The hour value was incorrect"
  end
  def test_set_day_to_1
    @crontab.day = "1"
    assert_equal "1", @crontab.day, "The day value was incorrect"
  end
  def test_set_day_to_1_by_int
    @crontab.day = 1
    assert_equal "1", @crontab.day, "The day value was incorrect"
  end
  def test_set_day_to_1_2_3
    set_to = "1,2,3"
    @crontab.day = set_to
    assert_equal set_to, @crontab.day, "The day value was incorrect"
  end
  def test_set_day_to_nil
    @crontab.day = nil
    assert_equal '*', @crontab.day, "The day value was incorrect"
  end
  def test_set_month_to_1
    @crontab.month = "1"
    assert_equal '1', @crontab.month, "The month value was incorrect"
  end
  def test_set_month_to_1_by_int
    @crontab.month = 1
    assert_equal '1', @crontab.month, "The month value was incorrect"
  end
  def test_set_month_to_1_2_3
    set_to = '1,2,3'
    @crontab.month = set_to
    assert_equal set_to, @crontab.month, "The month value was incorrect"
  end
  def test_set_month_to_nil
    @crontab.month = nil
    assert_equal '*', @crontab.month, "The month value was incorrect"
  end
  def test_set_weekday_to_1
    @crontab.weekday = '1'
    assert_equal '1', @crontab.weekday, "The weekday value was incorrect"
  end
  def test_set_weekday_to_1_by_int
    @crontab.weekday = 1
    assert_equal '1', @crontab.weekday, "The weekday value was incorrect"
  end
  def test_set_weekday_to_1_2_3
    set_to = '1,2,3'
    @crontab.weekday = set_to
    assert_equal set_to, @crontab.weekday, "The weekday value was incorrect"
  end
  def test_set_weekday_to_nil
    @crontab.weekday = nil
    assert_equal '*', @crontab.weekday, "The weekday value was incorrect"
  end
  def test_set_command_no_space
    @crontab.command = "foobar"
    assert_equal "foobar", @crontab.command, "The command value was incorrect"
  end
  def test_set_command_with_space
    set_to = "foo -bar | spam - > eggs.log"
    @crontab.command = set_to
    assert_equal set_to, @crontab.command, "The command value was incorrect"
  end
  def test_set_command_nill
    @crontab.command = nil
    assert_equal "", @crontab.command, "The command value was incorrect"
  end
end

class TestCrontabLineValidNumbers < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_minute_too_low
    assert_raise(RuntimeError) { @crontab.minute = -1 }
    assert_raise(RuntimeError) { @crontab.minute = -10 }
    assert_raise(RuntimeError) { @crontab.minute = -100 }
  end
  def test_minute_just_right
    (0..59).to_enum.each do |i|
      assert_nothing_raised(RuntimeError) { @crontab.minute = i }
      assert_equal i.to_s, @crontab.minute, "Minute value didn't match"
    end
  end
  def test_minute_too_high
    assert_raise(RuntimeError) {  @crontab.minute = 60 }
    assert_raise(RuntimeError) {  @crontab.minute = 100 }
    assert_raise(RuntimeError) {  @crontab.minute = 1000 }
  end
  def test_hour_too_low
    assert_raise(RuntimeError) { @crontab.hour = -1 }
    assert_raise(RuntimeError) { @crontab.hour = -10 }
    assert_raise(RuntimeError) { @crontab.hour = -100 }
  end
  def test_hour_just_right
    (0..23).to_enum.each do |i|
      assert_nothing_raised(RuntimeError) { @crontab.hour = i }
      assert_equal i.to_s, @crontab.hour, "Hour value didn't match"
    end
  end
  def test_hour_too_high
    assert_raise(RuntimeError) { @crontab.hour = 24 }
    assert_raise(RuntimeError) { @crontab.hour = 240 }
    assert_raise(RuntimeError) { @crontab.hour = 2400 }
  end
  def test_day_too_low
    assert_raise(RuntimeError) { @crontab.day = 0 }
    assert_raise(RuntimeError) { @crontab.day = -1 }
    assert_raise(RuntimeError) { @crontab.day = -10 }
  end
  def test_day_just_right
    (1..31).to_enum.each do |i|
      assert_nothing_raised(RuntimeError) { @crontab.day = i }
      assert_equal i.to_s, @crontab.day, "Day value didn't match"
    end
  end
  def test_day_too_high
    assert_raise(RuntimeError) { @crontab.day = 32 }
    assert_raise(RuntimeError) { @crontab.day = 320 }
    assert_raise(RuntimeError) { @crontab.day = 3200 }
  end
  def test_month_too_low
    assert_raise(RuntimeError) { @crontab.month = 0 }
    assert_raise(RuntimeError) { @crontab.month = -1 }
    assert_raise(RuntimeError) { @crontab.month = -10 }
  end
  def test_month_just_right
    (1..12).to_enum.each do |i|
      assert_nothing_raised(RuntimeError) { @crontab.month = i }
      assert_equal i.to_s, @crontab.month, "Month value didn't match"
    end
  end
  def test_month_too_high
    assert_raise(RuntimeError) { @crontab.month = 13 }
    assert_raise(RuntimeError) { @crontab.month = 100 }
    assert_raise(RuntimeError) { @crontab.month = 1000 }
  end
  def test_weekday_too_low
    assert_raise(RuntimeError) { @crontab.weekday = -1 }
    assert_raise(RuntimeError) { @crontab.weekday = -10 }
    assert_raise(RuntimeError) { @crontab.weekday = -100 }
  end
  def test_weekday_just_right
    (0..7).to_enum.each do |i|
      assert_nothing_raised(RuntimeError) { @crontab.weekday = i }
      assert_equal i.to_s, @crontab.weekday, "Weekday value didn't match"
    end
  end
  def test_weekday_too_high
    assert_raise(RuntimeError) { @crontab.weekday = 8 }
    assert_raise(RuntimeError) { @crontab.weekday = 10 }
    assert_raise(RuntimeError) { @crontab.weekday = 100 }
  end
end

class TestCrontabLineRanges < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_minute_range_low_end
    assert_nothing_raised(RuntimeError) { @crontab.minute = "0-5" }
    assert_equal "0-5", @crontab.minute
  end
  def test_minute_range_high_end
    assert_nothing_raised(RuntimeError) { @crontab.minute = "54-59"}
    assert_equal "54-59", @crontab.minute
  end
  def test_minute_entire_range
    assert_nothing_raised(RuntimeError) { @crontab.minute = "0-59" }
    assert_equal "0-59", @crontab.minute
  end
  def test_minute_multiple_ranges
    set_to = "0-5,10-15,50-59"
    assert_nothing_raised(RuntimeError) { @crontab.minute = set_to }
    assert_equal set_to, @crontab.minute
  end
  def test_minute_out_of_range_high
    assert_raise(RuntimeError) { @crontab.minute = "0-100" }
  end
  def test_minute_out_of_range_low
    assert_raise(RuntimeError) { @crontab.minute = "-1-59" }
  end
  def test_minute_multiple_out_of_range
    assert_raise(RuntimeError) { @crontab.minute = "0-5,50-100" }
  end
  def test_hour_range_low_end
    assert_nothing_raised(RuntimeError) { @crontab.hour = "0-5" }
    assert_equal "0-5", @crontab.hour
  end
  def test_hour_range_high_end
    assert_nothing_raised(RuntimeError) { @crontab.hour = "18-23" }
    assert_equal "18-23", @crontab.hour
  end
  def test_hour_entire_range
    assert_nothing_raised(RuntimeError) { @crontab.hour = "0-23" }
    assert_equal "0-23", @crontab.hour
  end
  def test_hour_multiple_ranges
    set_to = "0-1,2-3,8-10,15-23"
    assert_nothing_raised(RuntimeError) { @crontab.hour = set_to }
    assert_equal set_to, @crontab.hour
  end
  def test_hour_out_of_range_high
    assert_raise(RuntimeError) { @crontab.hour = "0-100" }
  end
  def test_hour_out_of_range_low
    assert_raise(RuntimeError) { @crontab.hour = "-1-23" }
  end
  def test_hour_multiple_out_of_range
    assert_raise(RuntimeError) { @crontab.hour = "0-10,15-24" }
  end
  def test_day_range_low_end
    assert_nothing_raised(RuntimeError) { @crontab.day = "1-6" }
    assert_equal "1-6", @crontab.day
  end
  def test_day_range_high_end
    assert_nothing_raised(RuntimeError) { @crontab.day = "26-31"}
    assert_equal "26-31", @crontab.day
  end
  def test_day_entire_range
    assert_nothing_raised(RuntimeError) { @crontab.day = "1-31" }
    assert_equal "1-31", @crontab.day
  end
  def test_day_multiple_ranges
    set_to = "1-5,10-15,20-30"
    assert_nothing_raised(RuntimeError) { @crontab.day = set_to }
    assert_equal set_to, @crontab.day
  end
  def test_day_out_of_range_high
    assert_raise(RuntimeError) { @crontab.day = "0-100" }
  end
  def test_day_out_of_range_low
    assert_raise(RuntimeError) { @crontab.day = "-1-31" }
  end
  def test_day_multiple_out_of_range
    assert_raise(RuntimeError) { @crontab.day = "0-10,30-35,15-25" }
  end
  def test_month_range_low_end
    assert_nothing_raised(RuntimeError) { @crontab.month = "1-6" }
    assert_equal "1-6", @crontab.month
  end
  def test_month_range_high_end
    assert_nothing_raised(RuntimeError) { @crontab.month = "5-12"}
    assert_equal "5-12", @crontab.month
  end
  def test_month_entire_range
    assert_nothing_raised(RuntimeError) { @crontab.month = "1-12" }
    assert_equal "1-12", @crontab.month
  end
  def test_month_multiple_ranges
    set_to = "1-3,5-8,11-12"
    assert_nothing_raised(RuntimeError) { @crontab.month = set_to }
    assert_equal set_to, @crontab.month
  end
  def test_month_out_of_range_high
    assert_raise(RuntimeError) { @crontab.month = "0-100" }
  end
  def test_month_out_of_range_low
    assert_raise(RuntimeError) { @crontab.month = "-1-12" }
  end
  def test_month_multiple_out_of_range
    assert_raise(RuntimeError) { @crontab.month = "1-3,5-8,11-14" }
  end
  def test_weekday_range_low_end
    assert_nothing_raised(RuntimeError) { @crontab.weekday = "0-3" }
    assert_equal "0-3", @crontab.weekday
  end
  def test_weekday_range_high_end
    assert_nothing_raised(RuntimeError) { @crontab.weekday = "4-7" }
    assert_equal "4-7", @crontab.weekday
  end
  def test_weekday_entire_range
    assert_nothing_raised(RuntimeError) { @crontab.weekday = "0-7" }
    assert_equal "0-7", @crontab.weekday
  end
  def test_weekday_multiple_ranges
    set_to = "1-2,3-4,6-7"
    assert_nothing_raised(RuntimeError) { @crontab.weekday = set_to }
    assert_equal set_to, @crontab.weekday
  end
  def test_weekday_out_of_range_high
    assert_raise(RuntimeError) { @crontab.weekday = "0-100" }
  end
  def test_weekday_out_of_range_low
    assert_raise(RuntimeError) { @crontab.weekday = "-1-7" }
  end
  def test_weekday_multiple_out_of_range
    assert_raise(RuntimeError) { @crontab.weekday = "0-2,4-10,7" }
  end
end

class TestCrontabLineStepping < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_minute_asterix_with_stepping
    set_to = '*/2'
    assert_nothing_raised(RuntimeError) { @crontab.minute = set_to }
    assert_equal set_to, @crontab.minute
  end
  def test_minute_range_with_stepping
    set_to = '0-30/5'
    assert_nothing_raised(RuntimeError) { @crontab.minute = set_to }
    assert_equal set_to, @crontab.minute
  end
  def test_minute_stepping_with_multiple_ranges
    set_to = '0-10/2,12,13-15,18-21/3'
    assert_nothing_raised(RuntimeError) { @crontab.minute = set_to }
    assert_equal set_to, @crontab.minute
  end
  def test_minute_stepping_with_no_range_raises
    set_to = '10/5'
    assert_raise(RuntimeError) { @crontab.minute = set_to }
  end
  def test_hour_asterix_with_stepping
    set_to = '*/2'
    assert_nothing_raised(RuntimeError) { @crontab.hour = set_to }
    assert_equal set_to, @crontab.hour
  end
  def test_hour_range_with_stepping
    set_to = '0-22/2'
    assert_nothing_raised(RuntimeError) { @crontab.hour = set_to }
    assert_equal set_to, @crontab.hour
  end
  def test_hour_stepping_with_multiple_ranges
    set_to = '0-10/2,16-22/2'
    assert_nothing_raised(RuntimeError) { @crontab.hour = set_to }
    assert_equal set_to, @crontab.hour
  end
  def test_hour_stepping_with_no_range_raises
    set_to = '10/5'
    assert_raise(RuntimeError) { @crontab.hour = set_to }
  end
  def test_day_asterix_with_stepping
    set_to = '*/2'
    assert_nothing_raised(RuntimeError) { @crontab.day = set_to }
    assert_equal set_to, @crontab.day
  end
  def test_day_range_with_stepping
    set_to = '1-30/5'
    assert_nothing_raised(RuntimeError) { @crontab.day = set_to }
    assert_equal set_to, @crontab.day
  end
  def test_day_stepping_with_multiple_ranges
    set_to = '1-11/2,15,20-30/2'
    assert_nothing_raised(RuntimeError) { @crontab.day = set_to }
    assert_equal set_to, @crontab.day
  end
  def test_day_stepping_with_no_range_raises
    set_to = '10/5'
    assert_raise(RuntimeError) { @crontab.day = set_to }
  end
  def test_month_asterix_with_stepping
    set_to = '*/2'
    assert_nothing_raised(RuntimeError) { @crontab.month = set_to }
    assert_equal set_to, @crontab.month
  end
  def test_month_range_with_stepping
    set_to = '2-12/2'
    assert_nothing_raised(RuntimeError) { @crontab.month = set_to }
    assert_equal set_to, @crontab.month
  end
  def test_month_stepping_with_multiple_ranges
    set_to = '1-3/2,5,7-11/2'
    assert_nothing_raised(RuntimeError) { @crontab.month = set_to }
    assert_equal set_to, @crontab.month
  end
  def test_month_stepping_with_no_range_raises
    set_to = '10/5'
    assert_raise(RuntimeError) { @crontab.month = set_to }
  end
  def test_weekday_asterix_with_stepping
    set_to = '*/2'
    assert_nothing_raised(RuntimeError) { @crontab.weekday = set_to }
    assert_equal set_to, @crontab.weekday
  end
  def test_weekday_range_with_stepping
    set_to = '0-4/2'
    assert_nothing_raised(RuntimeError) { @crontab.weekday = set_to }
    assert_equal set_to, @crontab.weekday
  end
  def test_weekday_stepping_with_multiple_ranges
    set_to = '0-3/3,4-6/2'
    assert_nothing_raised(RuntimeError) { @crontab.weekday = set_to }
    assert_equal set_to, @crontab.weekday
  end
  def test_weekday_stepping_with_no_range_raises
    set_to = '3/5'
    assert_raise(RuntimeError) { @crontab.weekday = set_to }
  end
end