require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it '名前、email、パスワードがあれば有効' do
    user1 = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    expect(user1).to be_valid
  end

  it '名前が記入されているか？' do
    user2 = User.new(name: "", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    expect(user2).to_not be_valid
  end

  it 'emailが記入されているか？' do
    user3 = User.new(name: "Example User", email: "    ",
                     password: "foobar", password_confirmation: "foobar")
    expect(user3).to_not be_valid
  end
  
  it 'emailのフォーマットは正しいかどうか？' do
    user4 = User.new
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user4.email = valid_address
      expect(user4).to_not be_valid
    end
  end  

  it 'emailが重複していないか？' do
    user5 = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    user5.save
    duplicate_user = user5.dup
    duplicate_user.email = user5.email.upcase
    duplicate_user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'emailが小文字で保存されるかどうか？' do
    user6 = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
    mixed_case_email = "Foo@ExAMPle.CoM"
    user6.email = mixed_case_email
    user6.save
    expect(user6.email.downcase).to eq(user6.reload.email)
  end

  it 'passwordが存在しているか？' do
    user7 = User.new
    user7.password = user7.password_confirmation = " "* 6
    expect(user7).to_not be_valid
  end

  it 'passwordは6文字以上を満たさなくてはならない' do
    user8 = User.new
    user8.password = user8.password_confirmation = "a"* 5
    expect(user8).to_not be_valid
  end

end
