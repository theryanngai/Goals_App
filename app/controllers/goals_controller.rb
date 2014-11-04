class GoalsController < ApplicationController
  def index
    @goals = Goal.where(private?: false)
    @goals += Goal.where(user_id: current_user.id).where(private?: true)
    render :index
  end
  
  def new
    @goal = Goal.new
    render :new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    
    if @goal.save
      flash.now[:alerts] = "gj u mad gol bro"
      redirect_to goal_url(@goal)
    else
      flash.now[:alerts] = @goal.errors.full_messages
      render :new
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
    render :show
  end
  
  private
  def goal_params
    params.require(:goal).permit(:title, :body, :private?)
  end
end
