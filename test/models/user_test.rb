require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'User' do
    let(:user) { build(:user, first_name: 'test', last_name: 'test', phone_number: '2223334444') }

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

    describe 'phone number formatting' do
      let(:expected_phone) { '+12223334444' }

      it 'normalizes phone number to the E.164 standard' do
        refute_equal expected_phone, user.phone_number

        user.save

        assert_equal expected_phone, user.phone_number
      end

      it 'can normalize formatted numbers' do
        number_formats = ['(222)-333-4444', '222-333-4444', '(222) 333-4444']

        number_formats.all? do |format|
          user.update(phone_number: format)
          assert_equal expected_phone, user.phone_number
        end
      end
    end
  end
end
