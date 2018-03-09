class LegacyLendingController < ApplicationController

  def index
    @header = "Legacy Lending Application"
    @title = "Legacy Lending Application"
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
    @header = "Return item"
    @title = "Return item"
    authorize! :manage, :legacy_lending
  end

  def item_browse
    @header = "Browse inventory"
    @title = "Browse inventory"
    authorize! :manage, :legacy_lending
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

  def reservations
    room = params[:room]
    room ||= ''

    case room.upcase()
      when "A5"
        @mrbs_area = 4
        @room_name = "Experimental Fabrication (A5)"
      when "A10"
        @mrbs_area = 6
        @room_name = "Physical Computing (A10)"
      when "A10A"
        @mrbs_area = 5
        @room_name = "Media Lab (A10A)"
      when "A29"
        @mrbs_area = 8
        @room_name = "IDeATe Lending (A29)"
      when "A30", "A31"
        @mrbs_area = 10
        @room_name = "Wood Shop (A30/A31)"
      when "106B", "106C"
        @mrbs_area = 7
        @room_name = "IDeATe Studios (106B/106C)"
      when "VR"
        @mrbs_area = 11
        @room_name = "VR Equipment"
      else
        @header = "Reservations"
        @title = "Reservations"
        render 'reservations_index'
    end

    @header = "#{ view_context.link_to 'Reservations', reservations_path } <small>#{@room_name}</small>".html_safe()
    @title = "Reservations &ndash; #{@room_name}".html_safe()
  end

  def schedule
    @header = "Shift schedule"
    @title = "Shift schedule"
    authorize! :manage, :legacy_lending
  end

  def nvbots
    @header = "NVBots live feed"
    @title = "NVBots live feed"
    authorize! :manage, :legacy_lending
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
      if card_number[/\A\d{9}\z/]
        andrewid = CarnegieMellonIDCard.get_andrewid_by_card_id(card_number)
      elsif card_number[/\A[0-9a-fA-F]{8}\z/]
        andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number)
      elsif card_number[/\A\d{10}\z/]
        andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number.to_i.to_s(16))
      end
      return andrewid
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
