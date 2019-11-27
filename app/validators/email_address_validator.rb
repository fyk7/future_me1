class EmailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ === value
      record.errors[attribute] << (options[:message] || "メールアドレスが正しくありません")
    end
  end
end