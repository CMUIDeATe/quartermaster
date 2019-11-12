class LegacyLendingController < ApplicationController
  def index
    @header = "Lending Application"
    @title = "Lending Application"
    authorize! :manage, :legacy_lending
  end

  def item_lend
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Lend item"
    @title = "Lend item"
    authorize! :manage, :legacy_lending
  end

  def item_return
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Return item"
    @title = "Return item"
    authorize! :manage, :legacy_lending
  end

  def item_reserves
    @header = "Course reserves"
    @title = "Course reserves"
    authorize! :manage, :legacy_lending
  end

  def item_inventory
    @header = "IDeATe Lending inventory"
    @title = "IDeATe Lending inventory"
    authorize! :read, :inventory
  end

  def sale_index
    @header = "Sales"
    @title = "Sales"
    authorize! :manage, :legacy_lending
  end

  def sale_student
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Sell to IDeATe student"
    @title = "Sell to IDeATe student"
    authorize! :manage, :legacy_lending
  end

  def sale_course
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Sell to course- or project-funded account"
    @title = "Sell to course- or project-funded account"
    authorize! :manage, :legacy_lending
  end

  def sale_student_return
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Return from IDeATe student"
    @title = "Return from IDeATe student"
    authorize! :manage, :legacy_lending
  end

  def sale_course_return
    @card_andrewid = session[:card_andrewid]
    @card_name = get_name_from_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Return from course- or project-funded account"
    @title = "Return from course- or project-funded account"
    authorize! :manage, :legacy_lending
  end

  def sale_inventory
    @header = "Materials price list"
    @title = "Materials price list"
    authorize! :read, :inventory
  end

  def schedule_shifts
    @header = "Shift schedule"
    @title = "Shift schedule"
    authorize! :read, :lending_shift_schedule
  end

  def schedule_deliveries
    @header = "Course delivery schedule"
    @title = "Course delivery schedule"
    authorize! :manage, :legacy_lending
  end

  def schedules
    @room = params[:room]
    @room ||= ''

    @mrbs_room = nil
    case @room.upcase()
      when "A5"
        @mrbs_area = 4
        @room_name = "Fabrication Lab (A5)"
        @room_full_name = "the Fabrication Lab"
      when "A5B"
        @mrbs_area = 12
        @room_name = "Laser Cutters (A5B)"
        @room_full_name = "the IDeATe laser cutters"
      when "A10"
        @mrbs_area = 6
        @room_name = "Physical Computing (A10)"
        @room_full_name = "the Physical Computing Lab"
      when "A10A"
        @mrbs_area = 5
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
        @room_name = "Large Project Build Space (A31)"
        @room_full_name = "the Large Project Build Space"
      when "106B"
        @mrbs_area = 7
        @mrbs_room = 58
        @room_name = "IDeATe Studio A (106B)"
        @room_full_name = "IDeATe Studio A"
      when "106C"
        @mrbs_area = 7
        @mrbs_room = 59
        @room_name = "IDeATe Studio B (106C)"
        @room_full_name = "IDeATe Studio B"
      when "106C"
      else
        flash[:alert] = "Room #{@room} does not exist."
        redirect_to root_path
    end

    @header = "Schedules <small>#{@room_name}</small>".html_safe()
    @title = "Schedules &ndash; #{@room_name}".html_safe()
    authorize! :read, :reservation
  end

  def card_input
    card_id = params[:card_input]
    unless card_id.nil? || card_id.empty?
      @card_andrewid = card_lookup(card_id)
      if @card_andrewid.nil?
        flash['alert'] = 'Invalid card ID.'
        logger.info "Logged card for invalid Andrew user from #{params[:card_input_redirect_action]} at #{Time.now}"
      else
        logger.info "Logged card for Andrew user '#{@card_andrewid}' from #{params[:card_input_redirect_action]} at #{Time.now}"
      end
      session['card_andrewid'] = @card_andrewid
      redirect_to action: params[:card_input_redirect_action]
    end

  end

  private

    def card_lookup card_number
      begin
        if card_number[/\A\d{9}\z/]
          andrewid = CarnegieMellonIDCard.get_andrewid_by_card_id(card_number)
        elsif card_number[/\A[0-9a-fA-F]{8}\z/]
          andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number)
        elsif card_number[/\A\d{10}\z/]
          andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number.to_i.to_s(16).rjust(8,"0"))
        end
        return andrewid
      rescue
        return nil
      end
    end

    def get_name_from_andrewid andrewid
      return '' if andrewid.nil? || andrewid.empty?
      begin
        person = CarnegieMellonPerson.find_by_andrewid(andrewid)
        return "#{person['sn']}, #{person['givenName']}"
      rescue
        return ''
      end
    end


end
