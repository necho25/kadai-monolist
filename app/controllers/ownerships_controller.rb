class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])#検索しあればｲﾝｽﾀﾝｽを返しなければ新規作成する。初期化するわけではない
    unless @item.persisted? #DBに保存されていいないなら下記を実行
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code) #その商品のcodeで情報を取得
      
      @item = Item.new(read(results.first))
      @item.save #とりあえず保存
    end
    if params[:type] == 'Want' #上記で保存したものがwantならwantとして保存？よくわからん
      current_user.want(@item) #一度上記で保存したものを更新している？
      flash[:success] = '商品をWantしました'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = 'wantから外しました'
    end
    redirect_back(fallback_location: root_path)
  end
end
