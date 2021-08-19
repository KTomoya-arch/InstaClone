class PostsController < ApplicationController
  #ログインしていないとできないアクションを定義する
  #:require_loginはsorceryのメソッド
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    #includesは複数のテーブルが関連している場合に関連付けされているテーブルのデータも事前に取得できるメソッド
    #投稿に紐づくユーザ情報もincludes(:user)⇦引数で指定して取得している
    #incluedsが無いと@posts.each do |post| ...post.usernameとした場合にループするたびにUserテーブルへ
    #データを取得しにいくと解釈した(要確認)
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params) 
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    # 失敗しないはずなので、もし失敗したら例外処理とする
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  private

  def post_params
    # images:[]とすることで、JSON形式でparamsを受け取る
    params.require(:post).permit(:body, images: [])
  end
end
