class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_root_path, except: [:index, :show]

  def index
  #indexアクションに、インスタンス変数@prototypesを定義し、すべてのプロトタイプの情報を代入した
    @prototypes = Prototype.all
  end

  # newアクションにインスタンス変数@prototypeを定義し、Prototypeモデルの新規オブジェクトを代入した
  def new
    @prototype = Prototype.new
  end

  def create
    #  createアクションにデータ保存のための記述をし、保存されたときはルートパスに戻るような記述をした
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      #  createアクションに、データが保存されなかったときは新規投稿ページへ戻るようrenderを用いて記述した
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # showアクションにインスタンス変数@prototypeを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
    @prototype = Prototype.find(params[:id])
    # prototypesコントローラーのshowアクションに、@commentというインスタンス変数を定義し、Commentモデルの新規オブジェクトを代入した
    # showアクションにインスタンス変数@commentsを定義し、その投稿に紐づくすべてのコメントを代入するための記述をした
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # editアクションにインスタンス変数@prototypeを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
    @prototype = Prototype.find(params[:id])
  end

  def update
    #  updateアクションにデータを更新する記述をし、更新されたときはそのプロトタイプの詳細ページに戻るような記述をした
    @prototype = Prototype.find(params[:id])
    if  @prototype.update(prototype_params)
        redirect_to prototype_path
    else
      #  updateアクションに、データが更新されなかったときは、編集ページに戻るようにrenderを用いて記述した
      #  バリデーションによって更新ができず編集ページへ戻ってきた場合でも、入力済みの項目（画像以外）は消えないことを確認した
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # destroyアクションに、プロトタイプを削除し、トップページに戻るような記述をした
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  private
  # prototypesコントローラーのprivateメソッドにストロングパラメーターをセットし、特定の値のみを受け付けるようにした。且つ、user_idもmergeした
  def prototype_params
    params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
  end

  def move_to_root_path
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user == @prototype.user
      redirect_to root_path
    end
  end

end

# http://localhost:3000/prototypes/4/edit
