# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string
#  session_token    :string
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          default(FALSE), not null
#  admin            :boolean          default(FALSE), not null
#  activation_token :string           not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # This line created when we run rails generate rspec:model User to create
  # this spec file
  # pending "add some examples to (or delete) #{__FILE__}"

  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testing, helps certian validations pass
  # as they need something in the db to compare to, so this fake item serves
  # that purpose

  # Could also use factory bot:
  # subject(:user) do
  #      FactoryBot.build(:user,
  #        email: "jonathan@fakesite.com",
  #        password: "good_password")
  #    end

  subject(:user) { User.new(email: 'testy@test.com', session_token: '123456', password_digest: '3213153321631', activated: true, admin: false, activation_token: "abcdefg", password: "good_password") }

  # validations
  describe 'validations' do

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:activation_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:notes) }
  end

  it "creates a password digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  it "creates a session token before validation" do
    user.valid?
    expect(user.session_token).to_not be_nil
  end

  describe 'class methods' do
    describe '#is_password?(password)' do
      it 'verifies password is correct' do
        expect(user.is_password?('good_password')).to be true
      end
      it 'verifies password is not correct' do
        expect(user.is_password?('bad_password')).to be false
      end
    end

    describe "find_by_credentials(email, password)" do
      before { user.save! }
      it 'finds a user when correct info given' do
        expect(User.find_by_credentials(user.email, user.password)).to eq(user)
      end
      it 'returns nil if incorrect password given' do
        expect(User.find_by_credentials(user.email, "bad_password")).to eq(nil)
      end
      it 'returns nil if incorrect email given' do
        expect(User.find_by_credentials("rando@mail.com", "bad_password")).to eq(nil)
      end
    end

    describe "reset_session_token" do
      it "sets a new session token on the user when called" do
        user.valid?
        old_session_token = user.session_token
        user.reset_session_token!

        # Slight chance this may fail due to collision, but very small
        expect(user.session_token).to_not eq(old_session_token)
      end

      it "returns the new session token when called" do
        expect(user.reset_session_token!).to eq(user.session_token)
      end
    end

  end

end
