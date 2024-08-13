class QuestionController
  def create
    @survey = Survey.find(params[:survey_id])

    @submittable_type = params[:submittable_type_id]

    question_params = params
      .require(:question)
      .permit(:submittable_type, :title, :options_attributes, :minimum, :maximum)
    @question = @survey.questions.new(question_params)
    @question.submittable_type = @submittable_type

    if @question.save
      redirect_to @survey
    else
      render :new
    end
  end
end

#===============================================================================

class QuestionController
  def create
    @submittable_type = params[:submittable_type_id]

    @question = survey.questions.new(question_params)

    @question.submittable_type = @submittable_type

    if @question.save
      redirect_to @survey
    else
      render :new
    end
  end

  private

  def survey
    @survey ||= Survey.find(params[:survey_id])
  end

  def question_params
    params
      .require(:question)
      .permit(:submittable_type, :title, :options_attributes, :minimum, :maximum)
  end
end
