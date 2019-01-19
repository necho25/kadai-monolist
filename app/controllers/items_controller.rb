class ItemsController < ApplicationController
  
  def new
    @items = [] #検索された時だけ使用するので空の配列として初期化しておく。がここで空として初期化してないとviewでnilとなりｴﾗｰになる
    
    @keyword = params[:keyword]
    if @keyword.present? #present?の逆がblank?つまり(present? == !blank) :keywordが入力されているならtrueを返す
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1, # imageFlagが1の時は画像ありのみを、0なら全てを対象とする
        hits: 20, #表示件数を20件に
      })
      
      results.each do |result| #取得し検索結果を扱えるようにだけして保存はしない
        item = Item.new(read(result))
        @item << item
      end
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
