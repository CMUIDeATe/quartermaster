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
    @header = "#{ view_context.link_to 'Schedules', schedule_index_path } <small>Shift schedule</small>".html_safe()
    @title = "Shift schedule"
    authorize! :read, :lending_shift_schedule
  end

  def schedule_deliveries
    @header = "#{ view_context.link_to 'Schedules', schedule_index_path } <small>Course delivery chedule</small>".html_safe()
    @title = "Course delivery schedule"
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
