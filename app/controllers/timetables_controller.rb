require 'ttable'
class TimetablesController < ApplicationController
    before_action :set_timetable, only: [:show, :edit, :update, :destroy]

    def intro
        @timetable = Timetable.all
    end

    def intro2
        @timetable = Timetable.last
        @group          = @timetable.group
        @timetables     = @group.timetables
        @users          = @group.users
        @marked_users   = @timetable.marks.where(user: @users).distinct

        @marks = @timetable.marks.on_this_week
        @t = Ttable.new(@marks)
    end

    # GET /timetables
    # GET /timetables.json
    def index
        @timetables = Timetable.all
    end

    # GET /timetables/1
    # GET /timetables/1.json
    def show
        @group          = @timetable.group
        @timetables     = @group.timetables
        @users          = @group.users
        @marked_users   = @timetable.marks.where(user: @users).distinct
    end

    # GET /timetables/new
    def new
        @timetable = Timetable.new
    end

    # GET /timetables/1/edit
    def edit
    end

    # POST /timetables
    # POST /timetables.json
    def create
        @timetable = Timetable.new(timetable_params)

        respond_to do |format|
            if @timetable.save
                format.html { redirect_to @timetable, notice: 'Timetable was successfully created.' }
                format.json { render :show, status: :created, location: @timetable }
            else
                format.html { render :new }
                format.json { render json: @timetable.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /timetables/1
    # PATCH/PUT /timetables/1.json
    def update
        respond_to do |format|
            if @timetable.update(timetable_params)
                format.html { redirect_to @timetable, notice: 'Timetable was successfully updated.' }
                format.json { render :show, status: :ok, location: @timetable }
            else
                format.html { render :edit }
                format.json { render json: @timetable.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /timetables/1
    # DELETE /timetables/1.json
    def destroy
        @timetable.destroy
        respond_to do |format|
            format.html { redirect_to timetables_url, notice: 'Timetable was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
        @timetable = Timetable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timetable_params
        params.require(:timetable).permit(:group_id, :start_date, :end_date)
    end
end
