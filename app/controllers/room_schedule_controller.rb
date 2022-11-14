class RoomScheduleController < ApplicationController

  def index
    @header = "Schedules"
    @title = "Schedules"

    # Include a day-at-a-glance for the classroom-type "area".
    @mrbs_area = 4
  end

  def show
    @room = params[:room]
    @room ||= ''

    @mrbs_room = nil
    case @room.upcase()
      when "A4"
        @mrbs_area = 4
        @mrbs_room = 70
        @room_name = "A4 Labs (A4)"
        @room_full_name = "the A4 Labs"
      when "A5"
        @mrbs_area = 4
        @mrbs_room = 42
        @room_name = "Fabrication Lab (A5)"
        @room_full_name = "the Fabrication Lab"
      when "A5B"
        @mrbs_area = 12
        @room_name = "Laser Cutters (A5B)"
        @room_full_name = "the IDeATe laser cutters"
      when "A10"
        @mrbs_area = 4
        @mrbs_room = 60
        @room_name = "Physical Computing (A10)"
        @room_full_name = "the Physical Computing Lab"
      when "A10A"
        @mrbs_area = 4
        @mrbs_room = 56
        @room_name = "Media Lab (A10A)"
        @room_full_name = "the Media Lab"
      when "A29"
        @mrbs_area = 8
        @room_name = "Lending Desk (A29)"
        @room_full_name = "the IDeATe Lending Desk"
      when "A30"
        @mrbs_area = 10
        @room_name = "Wood Shop (A30)"
        @room_full_name = "the IDeATe Wood Shop"
      when "A31"
        @mrbs_area = 13
        @mrbs_room = 69
        @room_name = "Soft Technologies Studio (A31)"
        @room_full_name = "the Soft Technologies Studio"
      when "106B"
        @mrbs_area = 4
        @mrbs_room = 58
        @room_name = "IDeATe Studio A (106B)"
        @room_full_name = "IDeATe Studio A"
      when "106C"
        @mrbs_area = 4
        @mrbs_room = 59
        @room_name = "IDeATe Studio B (106C)"
        @room_full_name = "IDeATe Studio B"
      else
        flash[:alert] = "Room #{@room} does not exist."
        redirect_to root_path
    end

    @header = "#{ view_context.link_to 'Schedules', schedule_index_path } <small>#{@room_name}</small>".html_safe()
    @title = "Schedules &ndash; #{@room_name}"
    authorize! :read, :reservation
  end

end
