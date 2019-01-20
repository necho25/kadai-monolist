class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    code = result ['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    # gsubは第一引数を見つけ出し第二引数に置換する。つまりex=128x128が削除されdefaultサイズになる
    
    {
    code: code, #上記で取得した値をハッシュにしている renderのとこでやる値の渡し方と同じ
    name: name,
    url: url,
    image_url: image_url,
    }
  end

end
