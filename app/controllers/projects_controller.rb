class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]

  def home
    render "projects/home"
  end

  def searchproject
    # byebug
    if params[:searchTerm].present?
       @projects = Project.where("lower(name) LIKE ?", "%" + Project.sanitize_sql_like(params[:searchTerm].to_s.downcase.gsub(/\s+/, '')) + "%")
      render json: @projects.map{|p| p.serializable_hash(only: [:id, :name]) }
    else
      render json: []
    end
  end
  # GET /projects or /projects.json
  def index
    if params[:name] == ""
       @projects = Project.all
    else
       @projects = Project.where("lower(name) LIKE ?", "%" + Project.sanitize_sql_like(params[:name].to_s.downcase.gsub(/\s+/, '')) + "%")
    end
  end

  def assign
    @project = Project.find(params[:id])
    @userproject = UserProject.create(user_id: params[:user_id],project_id: params[:id])
    redirect_to project_url(@project)
  end

  def remove
    @project = Project.find(params[:id])
    @userproject = UserProject.find_by(user_id: params[:user_id],project_id: @project.id)
    @userproject.destroy
    redirect_to project_url(@project)
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.user_projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
            # @userproject = UserProject.create(user_id: current_user.id,project_id: @project.id)
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    # byebug
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy

    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :user_id, user_projects_attributes: [:id, :project_id, :user_id, :_destroy])
    end
end
