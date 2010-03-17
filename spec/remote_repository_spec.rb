require 'pullr/remote_repository'

require 'spec_helper'

describe RemoteRepository do
  describe "SubVersion" do
    it "should have a name for URIs pointing to trunk/" do
      repo = RemoteRepository.new(
        :scm => :sub_version,
        :uri => 'http://www.example.com/var/svn/project/trunk'
      )

      repo.name.should == 'project'
    end

    it "should have a name for URIs pointing into branches/" do
      repo = RemoteRepository.new(
        :scm => :sub_version,
        :uri => 'http://www.example.com/var/svn/project/branches/awesome'
      )

      repo.name.should == 'project'
    end

    it "should have a name for URIs pointing into tags/" do
      repo = RemoteRepository.new(
        :scm => :sub_version,
        :uri => 'http://www.example.com/var/svn/project/tags/0.1.0'
      )

      repo.name.should == 'project'
    end
  end

  describe "Git" do
    it "should have a name" do
      repo = RemoteRepository.new(
        :scm => :git,
        :uri => 'http://www.example.com/var/git/project.git'
      )

      repo.name.should == 'project'
    end
  end
end
