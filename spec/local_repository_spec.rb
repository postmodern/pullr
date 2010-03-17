require 'pullr/local_repository'

require 'spec_helper'

describe LocalRepository do
  before(:all) do
    @repo = LocalRepository.new(
      :scm => :rsync,
      :path => File.join('some','repository')
    )
  end

  it "should have a name" do
    @repo.name.should == 'repository'
  end
end
