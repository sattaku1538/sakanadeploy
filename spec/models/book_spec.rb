require 'rails_helper'

RSpec.describe 'Bookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { book.valid? }

    context 'titleカラム' do
      it '空欄でないこと' do
        book.title = ''
        is_expected.to eq false
      end
    end
  end
end