require File.dirname(__FILE__) + '/spec_helper'

describe "Hash monkey: include_only?" do
  it "should return true if only the provided keys are found in the hash" do
    h = {:a => 0, :b => 1, :c => 2}
    {}.include_only?(:a).should be_true
    h.include_only?(:a).should be_false
    h.include_only?(:a, :b).should be_false
    h.include_only?(:a, :b, :c).should be_true
    h.include_only?(:a, :b, :c, :d).should be_true
  end
end


describe "Hash monkey: stringify keys" do
  it "should turn symbols into key" do
    h = {:a => 0, :b => 1, :c => 2}
    h.stringify_keys
    h.keys.size.should == 3
    h.has_key?(:a).should be_false
    h.has_key?(:b).should be_false
    h.has_key?(:c).should be_false
    h.has_key?('a').should be_true
    h.has_key?('b').should be_true
    h.has_key?('c').should be_true
  end
end

describe "Hash monkey: include_only" do
  it "shouldn't raise exception if only the provided keys are found in the hash" do
    h = {:a => 0, :b => 1, :c => 3}
    expect { {}.include_only(:a) }.to_not raise_error
    expect { h.include_only(:a) }.to raise_error
    expect { h.include_only(:a, :b) }.to raise_error
    expect { h.include_only(:a, :b, :c) }.to_not raise_error
    expect { h.include_only(:a, :b, :c, :d) }.to_not raise_error
  end
end

describe "Hash monkey: from_xml_string" do
  it "should create a hash of symbol => values" do
    xml = "<Error><Code>Hello</Code><Message>World</Message><MyDate>Now</MyDate></Error>"
    h = Hash.from_xml_string(xml)
    h.has_key?('Error').should be_true
    error = h['Error']
    error.has_key?('Code').should be_true
    error['Code'].should == "Hello"
    error.has_key?('Message').should be_true
    error['Message'].should == "World"
    error.has_key?('MyDate').should be_true
    error['MyDate'].should == "Now"
  end
  
  it "should raise exception on invalid xml" do
    xml = "<Error><Code>Hello</Code><Message>World</Message><MyDate>Now</BADTAG></Error>"
    expect { h = Hash.from_xml_string(xml) ; puts h.inspect }.to raise_error
  end
  
  it "should parse attributes" do
    xml = "<Tag attr=\"hello world\">Hello</Tag>"
    h = Hash.from_xml_string(xml)
    tag = h['Tag']
    tag.has_key?('attr')
    tag['attr'].should == "hello world"
    tag['text'].should == "Hello"
  end
  
  it "should handle multiple nested entries correctly" do
    xml = "<List><Item><Name>one</Name><Type>this</Type></Item><Item><Name>two</Name><Type>this</Type></Item><Item><Name>three</Name><Type>this</Type></Item></List>"
    h = Hash.from_xml_string(xml)
    list = h['List']
    list.has_key?('Item').should be_true
    list['Item'].length.should == 3
  end
end