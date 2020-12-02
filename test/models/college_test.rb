require 'test_helper'

class CollegeTest < ActiveSupport::TestCase
  describe 'College' do
    let(:college) { build(:college, name: 'Turing') }

    it 'is valid with all attributes' do
      assert college.valid?
    end

    it 'must have a name' do
      college.name = nil

      assert college.invalid?
    end

    it 'cannot have a duplicate name' do
      college.save
      dup_college = build(:college, name: college.name)

      assert dup_college.invalid?
    end
  end
end
