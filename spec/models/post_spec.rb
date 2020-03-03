require 'rails_helper'

RSpec.describe Post, type: :model do
  it "Factory(:post)が有効である" do
    expect(FactoryBot.build(:post)).to be_valid
  end

  it "51文字のtitleは無効である" do
    post = FactoryBot.build(:post, title: "t" * 100)
    post.valid?
    expect(post.errors[:title]).to include("は99文字以内で入力してください")
  end

  it "99文字のtitleは有効である" do
    expect(FactoryBot.build(:post, title: "t" * 99)).to be_valid
  end

  it "Contenttがなければ無効である" do
    post = FactoryBot.build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end

  it "1025文字のcontentは無効である" do
    post = FactoryBot.build(:post, content: "t" * 1025)
    post.valid?
    expect(post.errors[:content]).to include("は1024文字以内で入力してください")
  end

  it "1024文字のcontentは有効である" do
    expect(FactoryBot.build(:post, content: "t" * 1024)).to be_valid
  end

  it "publicの初期値はtrueである" do
    expect(FactoryBot.build(:post).public).to eq true
  end

end
