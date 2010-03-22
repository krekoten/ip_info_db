require File.join(File.basename(__FILE__), 'lib', 'ip_info_db')

if const_defined? 'Rails'
  require File.join(File.basename(__FILE__), 'lib', 'ip_info_db_rails')
end