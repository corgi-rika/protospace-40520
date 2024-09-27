class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    # newアクションにインスタンス変数@prototypeを定義し、Prototypeモデルの新規オブジェクトを代入した
    @prototype = Prototype.new
  end

  def create
    #createアクションにデータ保存のための記述をし、保存されたときはルートパスに戻るような記述をした
    @prototype = current_user.prototypes.build(prototype_params)
    # @prototype = current_user.prototypes.create(prototype_params) でも大丈夫？
    #createアクションに、データが保存されなかったときは新規投稿ページへ戻るようrenderを用いて記述した
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # showアクションにインスタンス変数@prototypeを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
    # showアクションにインスタンス変数@prototypeを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # editアクションにインスタンス変数@prototypeを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
  end

  def update
    #  updateアクションにデータを更新する記述をし、更新されたときはそのプロトタイプの詳細ページに戻るような記述をした
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      #  updateアクションに、データが更新されなかったときは、編集ページに戻るようにrenderを用いて記述した
      #  バリデーションによって更新ができず編集ページへ戻ってきた場合でも、入力済みの項目（画像以外）は消えないことを確認した
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # destroyアクションに、プロトタイプを削除し、トップページに戻るような記述をした
    @prototype.destroy
    redirect_to root_path
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end


    def move_to_index
      redirect_to root_path unless current_user == @prototype.user
    end

  def prototype_params
    # prototypesコントローラーのprivateメソッドにストロングパラメーターをセットし、特定の値のみを受け付けるようにした。且つ、user_idもmergeした
    params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
  end
end
