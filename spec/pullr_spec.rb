require 'pullr/version'

require 'spec_helper'

describe Pullr do
  it "should define a VERSION constant" do
    Pullr.should be_const_defined('VERSION')
  end
end
