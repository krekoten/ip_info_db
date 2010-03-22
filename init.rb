require File.join(File.dirname(__FILE__), 'lib', 'ip_info_db')

if Object.const_defined? 'Rails'
  require File.join(File.dirname(__FILE__), 'lib', 'ip_info_db_rails')
end