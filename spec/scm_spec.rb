require 'pullr/scm/scm'

require 'spec_helper'

describe SCM do
  it "should lookup an SCM with a String name" do
    SCM.lookup('git').should == SCM::Git
  end

  it "should lookup an SCM with a Symbol name" do
    SCM.lookup(:git).should == SCM::Git
  end

  it "should raise UnknownSCM when looking up unknown SCM names" do
    lambda {
      SCM.lookup(:bla)
    }.should raise_error(UnknownSCM)
  end
end
