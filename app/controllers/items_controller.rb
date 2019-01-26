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
      #スペースを複数挟んだキーワードで検索するとエラーが出る
      results.each do |result| #取得し検索結果を扱えるようにだけして保存はしない
        item = Item.find_or_initialize_by(read(result)) #既に保存されている Item に関しては、 item.id の値も含めたいからです。この item.id はフォームから Unwant するときに使用??
        @items << item
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
end
