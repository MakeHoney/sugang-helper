class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]
  def create
    @comment = @post.comments.create(params[:comment].permit[:content])
    @comment.user_id = current_user.id
    @comment.content = params[:comment]['content']

    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit
    loadList()
  end

  def update
    if @comment.update(params.require(:comment).permit(:content))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end


  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_comment
      @comment = @post.comments.find(params[:id])
    end

    def comment_owner
      unless current_user.id == @comment.user_id || @comment.deletable_by?(current_user)
        flash[:notice] = "접근 권한이 없습니다."
        redirect_to @post
      end
    end
end
