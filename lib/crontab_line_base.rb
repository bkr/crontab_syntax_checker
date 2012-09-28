class CrontabLineBase
  def self.make_cron_attr(field_sym)
    field_str = field_sym.to_s
    define_method(field_sym) do
      instance_variable_get("@#{field_str}").join(',')
    end
    define_method("#{field_str}=") do |value|
      param_setter("@#{field_str}".to_sym, value)
    end
  end
  def self.cron_attr_accessor(*args)
    args.each { |arg| self.make_cron_attr(arg) }
  end
end