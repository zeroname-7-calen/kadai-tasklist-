class TasksController < ApplicationController
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show

  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = "Task が正常に登録されました"
      redirect_to task_path(@task)
      # redirect_to root_url
    else
      flash.now[:danger] = "Task が登録されませんでした"
      render :new
    end
  end

  def edit

  end

  def update

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      # redirect_to @task
      # redirect_to edit_task_path
      redirect_to tasks_path
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = "Task は正常に削除されました"
    redirect_to tasks_url
    # redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    # @task.destroy
    unless @task
     redirect_to root_url
    end
  end
end
