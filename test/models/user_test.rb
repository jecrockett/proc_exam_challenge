require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'User' do
    let(:user) { build(:user, first_name: 'test', last_name: 'test', phone_number: '5555555555') }

    describe 'validations' do
      it 'is valid with all attributes provided' do
        assert user.valid?
      end

      # accommodate people who go by one legal name
      it 'is valid without a first name' do
        user.first_name = nil

        assert user.valid?
      end

      # do not assume everyone has their own mobile number, allow for shared home phones
      it 'is valid with a duplicate phone number' do
        user.save
        user_with_same_phone = user.dup.tap { |u| u.first_name = 'new name' }

        assert user_with_same_phone.valid?
      end

      it 'is invalid without a last name' do
        user.last_name = nil

        assert user.invalid?
      end

      # NOTE: the phonelib gem determines the validity of phone numbers
      it 'is invalid without a phone number' do
        user.phone_number = nil

        assert user.invalid?
      end

      it 'cannot be a duplicate' do
        user.save
        dup_user = user.dup

        assert dup_user.invalid?
      end
    end
  end
end
