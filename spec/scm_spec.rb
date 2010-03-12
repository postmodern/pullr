require 'pullr/scm/scm'

require 'spec_helper'
require 'addressable/uri'

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

  it "should infer the SCM from the scheme of a URI" do
    uri = Addressable::URI.parse('svn://sourceforge.net')

    SCM.infer_from_uri(uri).should == :sub_version
  end

  it "should infer the SCM from the extension of a URI" do
    uri = Addressable::URI.parse('git@github.com/user/project.git')

    SCM.infer_from_uri(uri).should == :git
  end
end
