class BugsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_bug, only: %i[ show edit update destroy ]

  # GET /bugs or /bugs.json
  def index
    @bugs = Bug.all
  end

  # GET /bugs/1 or /bugs/1.json
  def show
  end

  def assign
    @project = Project.find(params[:pid])
    @bug = Bug.find(params[:id])
    @bug.update_columns( user_id: current_user.id )

    redirect_to project_url(@project)
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit
    # @project = Project.find(params[:project_id])
  end

  # POST /bugs or /bugs.json
  def create
    # @project = Project.find(:bug[project_id])
    @bug = Bug.create(bug_params)
    redirect_to bugs_path(@bugs)

  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    # @project = Project.find(params[:bug_project_id])
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to bug_url(@bug), notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @project = Project.find(@bug.project_id)
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:title, :deadline, :type1, :status, :project_id)
    end
end
