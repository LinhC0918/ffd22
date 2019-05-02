class SuggestionsController < ApplicationController
  before_action :load_suggestion, only: %i(show destroy)

  def index
    @suggestions = Suggestion.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new suggestion_params
    if @suggestion.save
      flash[:success] = t ".message"
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def destroy
    if @suggestion.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_failed"
    end
    redirect_to :suggestions
  end

  private

  def suggestion_params
    params.require(:suggestion).permit :name, :classify, :message, :user_id
  end

  def load_suggestion
    @suggestion = Suggestion.find_by id: params[:id]
    return if @suggestion
    flash[:danger] = "Suggestion not found"
    redirect_to root_path
  end
end
