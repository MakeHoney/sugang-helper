class ApplicationController < ActionController::Base
    def authority_forbidden(error)
      Authority.logger.warn(error.message)
      redirect_to request.referrer.presence || root_path, :alert => 'You are not authorized to complete that action.'
    end
    
    def loadList
  
      if user_signed_in? && Student.exists?(stu_email: current_user.email)
        email = current_user.email;
        stu_infos = Student.find_by(stu_email: email);
        stu_major = stu_infos[:major_id];
        stu_id = stu_infos[:stu_id];
        coursesNotTake = Hash.new();
        coursesReco = Hash.new();
        3.times do |i|
          # 교양 major_id 통일시키고 교양도 띄워줘야함
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
  
        @Reco = Array.new();
        @Reco << coursesReco['Liberal_Arts'];
        @Reco << coursesReco['Required_Course'];
        @Reco << coursesReco['Elective_Course'];
  
      else
  
      end
    end
end
