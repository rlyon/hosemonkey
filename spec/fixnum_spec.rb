require File.dirname(__FILE__) + '/spec_helper'

describe "Fixnum monkey: " do
  it "days should return n number of days in the future" do
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    10.days.should == Time.mktime(1970,1,11,0,0,0)
  end
  
  it "hours should return n number of hours in the future" do
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    10.hours.should == Time.mktime(1970,1,1,10,0,0)
  end
  
  it "weeks should return n number of weeks in the future" do
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    2.weeks.should == Time.mktime(1970,1,15,0,0,0)
  end
  
  it "months should return n number of months in the future" do
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    15.months.should == Time.mktime(1971,4,1,0,0,0)
  end
  
  it "years should return n number of years in the future" do
    Time.stubs(:now).returns(Time.mktime(1970,1,1,0,0,0))
    15.years.should == Time.mktime(1985,1,1,0,0,0)
  end
end