class MainsController < ApplicationController
  before_action :set_main, only: [:show, :edit, :update, :destroy]

  # GET /mains
  # GET /mains.json
  def index
    @mains = Main.all

    if user_signed_in? && Student.exists?(stu_email: current_user.email)
      email = current_user.email;
      stu_infos = Student.find_by(stu_email: email);
      stu_major = stu_infos[:major_id];
      stu_id = stu_infos[:stu_id];
      coursesNotTake = Hash.new();
      3.times do |i|
        # 교양 major_id 통일시키고 교양도 띄워줘야함
        sql = "SELECT * FROM subjects WHERE major_id = #{stu_major} and category_id = #{i} and subj_id NOT IN (
               SELECT subj_id FROM take_subjects WHERE stu_id=#{stu_id}
              );"
        coursesNotTake[SubjectCategory.find(i).category_name] = Subject.connection.exec_query(sql).rows;
      end
      @Liberal_Arts = coursesNotTake['Liberal_Arts'];
      @Required_Course = coursesNotTake['Required_Course'];
      @Elective_Course = coursesNotTake['Elective_Course'];

    else

    end
  end

  # GET /mains/1
  # GET /mains/1.json
  def show
  end

  # GET /mains/new
  def new
    @main = Main.new
  end

  # GET /mains/1/edit
  def edit
  end

  # POST /mains
  # POST /mains.json
  def create
    @main = Main.new(main_params)

    respond_to do |format|
      if @main.save
        format.html { redirect_to @main, notice: 'Main was successfully created.' }
        format.json { render :show, status: :created, location: @main }
      else
        format.html { render :new }
        format.json { render json: @main.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mains/1
  # PATCH/PUT /mains/1.json
  def update
    respond_to do |format|
      if @main.update(main_params)
        format.html { redirect_to @main, notice: 'Main was successfully updated.' }
        format.json { render :show, status: :ok, location: @main }
      else
        format.html { render :edit }
        format.json { render json: @main.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mains/1
  # DELETE /mains/1.json
  def destroy
    @main.destroy
    respond_to do |format|
      format.html { redirect_to mains_url, notice: 'Main was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main
      @main = Main.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_params
      params.fetch(:main, {})
    end
end
