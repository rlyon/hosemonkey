require File.dirname(__FILE__) + '/spec_helper'

describe "Time monkey: " do
  it "to_z should return the correct value" do
    # Converts to gmt
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    Time.now.to_z.should == "1970-01-01T08:00:00.000Z"
  end
  
  it "to_web should return the correct value" do
    # Converts to gmt
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    Time.now.to_web.should == "Thu, 01 Jan 1970 08:00:00 +0000"
  end
  
  it "to_yearmonth should return the correct value" do
    # Converts to gmt
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    Time.now.to_yearmonth.should == "197001"
  end
end