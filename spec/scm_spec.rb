require 'pullr/scm/scm'

require 'spec_helper'
require 'addressable/uri'
require 'fileutils'
require 'tmpdir'

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

  describe "Git" do
    it "should be known as 'git'" do
      SCM.lookup(:git).should == SCM::Git
    end

    it "should be inferable from the scheme of a URI" do
      uri = Addressable::URI.parse('git://sourceforge.net')

      SCM.infer_from_uri(uri).should == :git
    end

    it "should be inferable from the extension of a URI" do
      uri = Addressable::URI.parse('git@github.com/user/project.git')

      SCM.infer_from_uri(uri).should == :git
    end

    it "should be inferable from the SCM control directory" do
      repo = Dir.mktmpdir('repo')
      FileUtils.mkdir(File.join(repo,'.git'))

      SCM.infer_from_dir(repo).should == :git
    end
  end

  describe "Mercurial" do
    it "should be known as 'mercurial'" do
      SCM.lookup(:mercurial).should == SCM::Mercurial
    end

    it "should also be known as 'hg'" do
      SCM.lookup(:hg).should == SCM::Mercurial
    end

    it "should be inferable from the scheme of a URI" do
      uri = Addressable::URI.parse('hg://sourceforge.net')

      SCM.infer_from_uri(uri).should == :mercurial
    end

    it "should be inferable from the SCM control directory" do
      repo = Dir.mktmpdir('repo')
      FileUtils.mkdir(File.join(repo,'.hg'))

      SCM.infer_from_dir(repo).should == :mercurial
    end
  end

  describe "SubVersion" do
    it "should be known as 'sub_version'" do
      SCM.lookup(:sub_version).should == SCM::SubVersion
    end

    it "should also be known as 'subversion'" do
      SCM.lookup(:subversion).should == SCM::SubVersion
    end

    it "should also be known as 'svn'" do
      SCM.lookup(:svn).should == SCM::SubVersion
    end

    it "should be inferable from the scheme of a URI" do
      uri = Addressable::URI.parse('svn://sourceforge.net')

      SCM.infer_from_uri(uri).should == :sub_version
    end

    it "should be inferable from the 'svn+ssh' URI scheme " do
      uri = Addressable::URI.parse('svn+ssh://sourceforge.net')

      SCM.infer_from_uri(uri).should == :sub_version
    end

    it "should be inferable from the SCM control directory" do
      repo = Dir.mktmpdir('repo')
      FileUtils.mkdir(File.join(repo,'.svn'))

      SCM.infer_from_dir(repo).should == :sub_version
    end
  end

  describe "Rsync" do
    it "should be known as 'rsync'" do
      SCM.lookup(:rsync).should == SCM::Rsync
    end

    it "should be inferable from the scheme of a URI" do
      uri = Addressable::URI.parse('rsync://sourceforge.net')

      SCM.infer_from_uri(uri).should == :rsync
    end
  end
end
