require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    it "200レスポンスを返す事" do
      get :index
      expect(response).to have_http_status "200"
    end

    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常なレスポンスを返す事" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#show" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
    end

    it "200レスポンスを返す事" do
      get :show, params: {id: @post.id}
      expect(response).to have_http_status "200"
    end
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常なレスポンスを返す事" do
        sign_in @user
        get :show, params: {id: @post.id}
        expect(response).to have_http_status "200"
      end
    end
  end

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
      end
      it "Postを登録できる事" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect{ post :create,
               params: {post: post_params}}.to change(Post, :count).by(1)
      end
    end

    context "ゲストとして" do
      it "ログイン画面へリダイレクトする事" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: {post: post_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @other_user = FactoryBot.create(:user)
        @other_post = FactoryBot.create(:post, user: @other_user)
      end

      it "自分のPostを削除できる事" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect{ delete :destroy,
               params: {id: @post.id}}.to change(@user.posts, :count).by(-1)
      end
      it "他人のPost削除はできない" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect{ delete :destroy,
               params: {id: @other_post.id}}.to change(@other_user.posts, :count).by(0)
      end
      it "他人のPost削除はリダイレクトする" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        delete :destroy, params: {id: @other_post.id}
        expect(response).to redirect_to "/posts"
      end
    end

    context "ゲストとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end
      it "ログイン画面へリダイレクトする事" do
        delete :destroy, params: {id: @post.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#edit" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @other_user = FactoryBot.create(:user)
        @other_post = FactoryBot.create(:post, user: @other_user)
      end

      it "自分のPostを編集できる事" do
        sign_in @user
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status "200"
      end

      it "他人のPost編集はリダイレクトする" do
        sign_in @user
        get :edit, params: {id: @other_post.id}
        expect(response).to redirect_to "/posts"
      end

    end

    context "ゲストとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end
      it "ログイン画面へリダイレクトする事" do
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @other_user = FactoryBot.create(:user)
        @other_post = FactoryBot.create(:post, user: @other_user)
      end
      it "Postを更新できる事" do
        post_params = FactoryBot.attributes_for(:post, title: "updated")
        sign_in @user
        patch :update, params: {id: @post.id, post: post_params}
        post = Post.first
        expect( post.title).to eq "updated"
      end
      it "他人のPost更新はリダイレクトする" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        patch :update, params: {id: @other_post.id, post: post_params}
        expect(response).to redirect_to "/posts"
      end
    end

    context "ゲストとして" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end
      it "ログイン画面へリダイレクトする事" do
        post_params = FactoryBot.attributes_for(:post)
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
