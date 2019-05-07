require 'rails_helper'

RSpec.describe Review do
  describe "relationships" do
    it { should belong_to :book }
  end

end
