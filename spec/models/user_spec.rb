# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: 'example user', email: 'user@example.net',
                            password: 'foobar', password_confirmation: 'foobar') }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}
  
  it { should be_valid }
  
  describe 'when name is not present' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end
  
  describe 'when name is too long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }    
  end

  # before { @user = User.new(name: 'example user', email: 'user@example.net') }
  
  describe 'when email is invalid' do
    it 'should be invalid' do
      emails = %w[ user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com ]
      emails.each do |x|
        @user.email = x
        @user.should_not be_valid
      end
    end
  end
  
  describe 'when email is valid' do
    it 'should be valid' do
      emails = %w[ user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn ]
      emails.each do |x|
        @user.email = x
        @user.should be_valid
      end
    end
  end
  
  describe 'when email is not unique' do
    before do
      user2 = @user.dup
      user2.email = @user.email.upcase
      user2.save
    end
    it { should_not be_valid }
  end

  describe 'when password is blank' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end

  describe 'when password confirmation is nil' do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe 'when password does not match confirmation' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end
  
  describe 'when a password is to short' do
    before { @user.password = @user.password_confirmation = 'a'*5 }
    it { should be_invalid }
  end
  
  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    describe 'with valid password' do
      it { should == found_user.authenticate(@user.password) }
    end
    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
end
