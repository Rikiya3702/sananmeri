require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "#new" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "200レスポンスを返す事" do
        sign_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返す事" do
        get :new
        expect(response).to have_http_status "302"
      end
      it "ログイン画面へリダイレクトする事" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end
      it "Commentを登録できる事" do
        comment_params = FactoryBot.attributes_for(:comment, user_id: @user.id, post_id: @post.id)
        sign_in @user
        expect{ post :create,
               params: {post: comment_params}}.to change(Comment, :count).by(1)
      end
    end

    context "ゲストとして" do
      it "ログイン画面へリダイレクトする事" do
        comment_params = FactoryBot.attributes_for(:comment)
        post :create, params: {post: comment_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @comment = FactoryBot.create(:comment, user: @user)
        @other_user = FactoryBot.create(:user)
        @other_comment = FactoryBot.create(:comment, user: @other_user)
      end

      it "自分のCommentを削除できる事" do
        comment_params = FactoryBot.attributes_for(:comment)
        sign_in @user
        expect{ delete :destroy,
               params: {id: @comment.id}}.to change(@user.comments, :count).by(-1)
      end
      it "他人のComment削除はできない" do
        comment_params = FactoryBot.attributes_for(:comment)
        sign_in @user
        expect{ delete :destroy,
               params: {id: @other_comment.id}}.to change(@other_user.comments, :count).by(0)
      end
      it "他人のComment削除はリダイレクトする" do
        comment_params = FactoryBot.attributes_for(:comment)
        sign_in @user
        delete :destroy, params: {id: @other_comment.id}
        expect(response).to redirect_to "/posts"
      end
    end

    context "ゲストとして" do
      before do
        @user = FactoryBot.create(:user)
        @comment = FactoryBot.create(:comment, user: @user)
      end
      it "ログイン画面へリダイレクトする事" do
        delete :destroy, params: {id: @comment.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
