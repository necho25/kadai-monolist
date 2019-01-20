class ToppagesController < ApplicationController
  def index
    @items = Item.order('updated_at DESC') #このorderは何？ 更新日の新しい順=updated_at DESC
  end
end
