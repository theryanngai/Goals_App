class GoalsController < ApplicationController
  def index
    @goals = Goal.where(restricted: false)
    @goals += Goal.where(user_id: current_user.id).where(restricted: true)
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
    set_current_goal
    render :show
  end
  
  def edit
    set_current_goal
    render :edit
  end
  
  def update
    set_current_goal
    
    if @goal.update(goal_params)
      flash.now[:alerts] = "You did gud bb"
      redirect_to goal_url(@goal)
    else
      flash.now[:alerts] = @goal.errors.full_messages 
      render :new
    end
  end
  
  private
  def goal_params
    params.require(:goal).permit(:title, :body, :restricted)
  end
  
  def set_current_goal
    @goal = Goal.find(params[:id])
  end
end
