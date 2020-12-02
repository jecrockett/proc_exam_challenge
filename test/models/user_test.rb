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

      it 'is invalid without a last name' do
        user.last_name = nil

        assert user.invalid?
      end

      describe 'phone number' do
        # NOTE: the phonelib gem determines the validity of phone numbers

        it 'is invalid without a phone number' do
          user.phone_number = nil

          assert user.invalid?
        end

        it 'is invalid with a duplicate phone number' do
          user.save
          dup_user = build(:user, phone_number: user.phone_number)

          assert dup_user.invalid?
        end
      end
    end
  end
end
