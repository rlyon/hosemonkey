module Hosemonkey
  module Boolean
    Mapping = {
      true    => true,
      'true'  => true,
      '1'     => true, 
      1       => true, 
      false   => false, 
      'false' => false,
      '0'     => false,
      0       => false, 
      nil     => nil
    }
  end
end

class Boolean ; include Hosemonkey::Boolean ; end