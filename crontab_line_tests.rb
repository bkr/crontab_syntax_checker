require 'test/unit'
require 'crontab_syntax_checker'

class TestCrontabLineGetters < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_default_minute
    assert_equal @crontab.minute, '*', "Default minute is wrong"
  end
  def test_default_hour
    assert_equal @crontab.hour, '*', "Default hour is wrong"
  end
  def test_default_day
    assert_equal @crontab.day, '*', "Default day is wrong"
  end
  def test_default_month
    assert_equal @crontab.month, '*', "Default month is wrong"
  end
  def test_default_weekday
    assert_equal @crontab.weekday, '*', "Default weekday is wrong"
  end
  def test_default_command
    assert_equal @crontab.command, '', "Default command is wrong"
  end
end

class TestCrontabLineSetters < Test::Unit::TestCase
  def setup
    @crontab = CrontabLine.new
  end
  def test_set_minute_to_1
    @crontab.minute = "1"
    assert_equal @crontab.minute, "1", "The minute value was incorrect"
  end
  def test_set_minute_to_1_by_int
    @crontab.minute = 1
    assert_equal @crontab.minute, "1", "The minute value was incorrect"
  end
  def test_set_minute_to_1_2_3
    set_to = "1,2,3"
    @crontab.minute = set_to
    assert_equal @crontab.minute, set_to, "The minute value was incorrect"
  end
  def test_set_minute_to_nil
    @crontab.minute = nil
    assert_equal @crontab.minute, '*', "The minute value was incorrect"
  end
  def test_set_hour_to_1
    @crontab.hour = "1"
    assert_equal @crontab.hour, "1", "The hour value was incorrect"
  end
  def test_set_hour_to_1_by_int
    @crontab.hour = 1
    assert_equal @crontab.hour, "1", "The hour value was incorrect"
  end
  def test_set_hour_to_1_2_3
    set_to = "1,2,3"
    @crontab.hour = set_to
    assert_equal @crontab.hour, set_to, "The hour value was incorrect"
  end
  def test_set_hour_to_nil
    @crontab.hour = nil
    assert_equal @crontab.hour, '*', "The hour value was incorrect"
  end
  def test_set_day_to_1
    @crontab.day = "1"
    assert_equal @crontab.day, "1", "The day value was incorrect"
  end
  def test_set_day_to_1_by_int
    @crontab.day = 1
    assert_equal @crontab.day, "1", "The day value was incorrect"
  end
  def test_set_day_to_1_2_3
    set_to = "1,2,3"
    @crontab.day = set_to
    assert_equal @crontab.day, set_to, "The day value was incorrect"
  end
  def test_set_day_to_nil
    @crontab.day = nil
    assert_equal @crontab.day, '*', "The day value was incorrect"
  end
  def test_set_month_to_1
    @crontab.month = "1"
    assert_equal @crontab.month, '1', "The month value was incorrect"
  end
  def test_set_month_to_1_by_int
    @crontab.month = 1
    assert_equal @crontab.month, '1', "The month value was incorrect"
  end
  def test_set_month_to_1_2_3
    set_to = '1,2,3'
    @crontab.month = set_to
    assert_equal @crontab.month, set_to, "The month value was incorrect"
  end
  def test_set_month_to_nil
    @crontab.month = nil
    assert_equal @crontab.month, '*', "The month value was incorrect"
  end
  def test_set_weekday_to_1
    @crontab.weekday = '1'
    assert_equal @crontab.weekday, '1', "The weekday value was incorrect"
  end
  def test_set_weekday_to_1_by_int
    @crontab.weekday = 1
    assert_equal @crontab.weekday, '1', "The weekday value was incorrect"
  end
  def test_set_weekday_to_1_2_3
    set_to = '1,2,3'
    @crontab.weekday = set_to
    assert_equal @crontab.weekday, set_to, "The weekday value was incorrect"
  end
  def test_set_weekday_to_nil
    @crontab.weekday = nil
    assert_equal @crontab.weekday, '*', "The weekday value was incorrect"
  end
  def test_set_command_no_space
    @crontab.command = "foobar"
    assert_equal @crontab.command, "foobar", "The command value was incorrect"
  end
  def test_set_command_with_space
    set_to = "foo -bar | spamm - > eggs.log"
    @crontab.command = set_to
    assert_equal @crontab.command, set_to, "The command value was incorrect"
  end
  def test_set_command_nill
    @crontab.command = nil
    assert_equal @crontab.command, "", "The command value was incorrect"
  end
end