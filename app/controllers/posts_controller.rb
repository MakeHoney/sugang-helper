class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :index, :show ]
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @postsSoft = Post.where(category_id: 1)
    @postsCyber = Post.where(category_id: 2)
    
    loadList()
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    loadList();
    @comments = Comment.where(post_id: @post).order("created_at DESC")
    if Student.exists?(stu_email: @post.user.email)
      email = @post.user.email;
      stu_infos = Student.find_by(stu_email: email);
      stu_major = stu_infos[:major_id];
      stu_id = stu_infos[:stu_id];
      coursesNotTake = Hash.new();
      coursesReco = Hash.new();
      3.times do |i|
        sql = "SELECT * FROM subjects WHERE (category_id = 0 or major_id = #{stu_major}) and category_id = #{i} and subj_id NOT IN (
               SELECT subj_id FROM take_subjects WHERE stu_id=#{stu_id}
              );"
        coursesNotTake[SubjectCategory.find(i).category_name] = Subject.connection.exec_query(sql).rows;
      end
    
      3.times do |i|
        sql2 = "SELECT * FROM subjects WHERE (category_id = 0 or major_id = #{stu_major}) and category_id = #{i} and subj_id NOT IN (
               SELECT subj_id FROM take_subjects WHERE stu_id=#{stu_id}
              ) order by subj_grade asc limit 5;"
        coursesReco[SubjectCategory.find(i).category_name] = Subject.connection.exec_query(sql2).rows;
      end
    
      @Liberal_Arts = coursesNotTake['Liberal_Arts'];
      @Required_Course = coursesNotTake['Required_Course'];
      @Elective_Course = coursesNotTake['Elective_Course'];
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    loadList()
  end

  # GET /posts/1/edit
  def edit
    authorize_action_for @post
    loadList()
  end

  # POST /posts
  # POST /posts.json
  def create
    loadList();
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    loadList()
    authorize_action_for @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    loadList()
    authorize_action_for @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :category_id, :desc)
    end
end
