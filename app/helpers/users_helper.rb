module UsersHelper
  def gravatar_url(user, options = {size:80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mp"
    #末尾の&d=mpでgravatarに登録されていない時に使用するﾃﾞﾌｫﾙﾄｲﾒｰｼﾞを変更している
  end
end
