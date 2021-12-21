class Admin::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @keyword = params[:keyword]
    keyword = "%#{@keyword}%"
    convert_kana = @keyword.tr('ぁ-ん','ァ-ン')
    kana_keyword = "%#{convert_kana}%"
    condition = 'introduction LIKE? OR name LIKE? || title LIKE? OR place LIKE? OR explanation LIKE?'

    # セレクトボックスで選んだ内容で分岐
    case @model
    when 'book' then
      @books = Product.search_for(@keyword).page(params[:page])
    when 'customer' then
      @customers = Customer.where([condition, keyword, keyword, keyword, kana_keyword, kana_keyword, kana_keyword]).page(params[:page]).reverse_order
    end
  end
end
