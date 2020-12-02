require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  describe 'Exam' do
    let(:exam) { build(:exam, name: 'Love of Coding Exam', college: create(:college)) }
    
    it 'is valid with all attributes' do
      assert exam.valid?
    end

    it 'must have a name' do
      exam.name = nil

      assert exam.invalid?
    end

    it 'must belong to a college' do
      exam.college = nil

      assert exam.invalid?
    end
  end
end
