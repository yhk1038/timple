class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :edit, :update, :destroy]
    
    # GET /groups
    # GET /groups.json
    def index
        redirect_to root_path unless user_signed_in?
        @groups = current_user.groups.order(created_at: :desc) # Group.all
    end
    
    # GET /groups/1
    # GET /groups/1.json
    def show
    end
    
    # GET /groups/new
    def new
        @group = Group.new
    end
    
    # GET /groups/1/edit
    def edit
    end
    
    # POST /groups
    # POST /groups.json
    def create
        @group = Group.new(group_params)
        
        Userlist.create(user: current_user, group: @group)
        
        current_date = Time.new
        beginning_of_current_week = current_date.beginning_of_week
        end_of_current_week = current_date.end_of_week
        
        @timetable = Timetable.create(group:   @group,
                                      start_date:       beginning_of_current_week,
                                      end_date:         end_of_current_week,
                                      start_day_time:   Time.new(current_date.year, current_date.month, current_date.day, 6, 0),
                                      end_day_time:     Time.new(current_date.year, current_date.month, current_date.day, 22, 59))
        
        respond_to do |format|
            if @group.save
                format.html { redirect_to group_timetable_path(@group, @timetable), notice: "'#{@group.name}' 의 테이블 입니다.<br>시간 입력할 준비, 되셨나요?" }
                format.json { render :show, status: :created, location: @group }
            else
                format.html { render :new }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /groups/1
    # PATCH/PUT /groups/1.json
    def update
        respond_to do |format|
            if @group.update(group_params)
                format.html { redirect_to @group, notice: 'Group was successfully updated.' }
                format.json { render :show, status: :ok, location: @group }
            else
                format.html { render :edit }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # DELETE /groups/1
    # DELETE /groups/1.json
    def destroy
        @group.destroy
        respond_to do |format|
            format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
            format.json { head :no_content }
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
        @group = Group.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
        params.require(:group).permit(:name, :description, :profile_img, :background_img, :invite_code, :privated)
    end
end
