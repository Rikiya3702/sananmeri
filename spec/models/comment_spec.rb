require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "Factory(:comment)が有効である" do
    expect(FactoryBot.build(:comment)).to be_valid
  end
  it "user_idがなければ無効である" do
    comment = FactoryBot.build(:comment, user_id: nil)
    comment.valid?
    expect(comment.errors[:user_id]).to include("を入力してください")
  end
  it "post_idがなければ無効である" do
    comment = FactoryBot.build(:comment, post_id: nil)
    comment.valid?
    expect(comment.errors[:post_id]).to include("を入力してください")
  end
  it "Contenttがなければ無効である" do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("を入力してください")
  end

  it "256文字のcontentは無効である" do
    comment = FactoryBot.build(:comment, content: "t" * 256)
    comment.valid?
    expect(comment.errors[:content]).to include("は255文字以内で入力してください")
  end

  it "1024文字のcontentは有効である" do
    expect(FactoryBot.build(:comment, content: "t" * 255)).to be_valid
  end

  it "userの削除と共にcommentが削除される" do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)


    post2 = Post.find(post.id)

    expect{ user.destroy }.to change(Post, :count).by(-1)
  end

end
