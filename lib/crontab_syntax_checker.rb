require 'crontab_line'

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