require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
    end

    it "200レスポンスを返す事" do
      get :show, params: {id: @user.id}
      expect(response).to have_http_status "200"
    end

    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常なレスポンスを返す事" do
        sign_in @user
        get :show, params: {id: @user.id}
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#destroy" do
    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "他人の削除はできない" do
        sign_in @user
        delete :destroy, params: {id: @other_user.id}
        expect(@other_user.deleted_at).to eq nil
      end
      it "他人の削除はリダイレクトする" do
        sign_in @user
        delete :destroy, params: {id: @other_user.id}
        expect(response).to redirect_to "/users"
      end
      it "自分を削除できる" do
        sign_in @user
        delete :destroy, params: {id: @user.id}
        user = User.only_deleted.find(@user.id)
        expect(user.deleted_at).to_not eq nil
      end
    end

    context "ゲストとして" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "ログイン画面へリダイレクトする事" do
        delete :destroy, params: {id: @user.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end


end
