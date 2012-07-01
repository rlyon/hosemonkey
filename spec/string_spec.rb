require File.dirname(__FILE__) + '/spec_helper'

describe "String monkey: hex" do
  it "shouldn't accept shitty args" do
    expect { String.hex(:length => 100, :case => :upper, :bad => 'yep') }.to raise_error
  end
  
  it "should return an upper case hex string" do
    s = String.hex(:length => 100, :case => :upper)
    (s =~ /^[abcdef0-9]+$/).should be_nil
    (s =~ /^[ABCDEF0-9]+$/).should >= 0
  end
  
  it "should return a lower case hex string" do
    s = String.hex(:length => 100, :case => :lower)
    (s =~ /^[abcdef0-9]+$/).should >= 0
    (s =~ /^[ABCDEF0-9]+$/).should be_nil
  end
end

describe "String monkey: random" do
  it "should return an exception if an invalid option is passed" do
    expect { String.random(:length => 100, :bad => 'yep') }.to raise_error
  end
  
  it "should return a alpha only string" do
    s = String.random(:length => 100, :charset => :alpha)
    (s =~ /^[a-zA-Z]+$/).should >= 0
    (s =~ /^[0-9]+$/).should be_nil
  end
  
  it "should return a uppercase alphanumeric only string" do
    s = String.random(:length => 100, :charset => :alnum_upper)
    (s =~ /^[0-9A-Z]+$/).should >= 0
    (s =~ /^[a-z]+$/).should be_nil
  end
end

describe "String monkey: camalize" do
  it "should camelize a string" do
    c = "hello_world"
    c.camelize.should == "HelloWorld"
  end
end