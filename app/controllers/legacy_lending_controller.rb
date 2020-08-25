class LegacyLendingController < ApplicationController
  def index
    @header = "Lending Application"
    @title = "Lending Application"
    authorize! :manage, :legacy_lending
  end

  def item_prepare
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Prepare items"
    @title = "Prepare items"
    authorize! :manage, :legacy_lending
  end

  def item_lend
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Lend items"
    @title = "Lend items"
    authorize! :manage, :legacy_lending
  end

  def item_return
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    @scan_input = session[:scan_input]
    session['card_andrewid'] = nil
    session['scan_input'] = nil

    @header = "Return items"
    @title = "Return items"
    authorize! :manage, :legacy_lending
  end

  def item_renew
    @tx_id = params[:txid]
    @renew_key = params[:renewkey]

    if @tx_id.nil? || @renew_key.nil?
      flash[:alert] = "Transaction ID and renewal key are required."
      redirect_to root_path
    end

    @header = "Renew item"
    @title = "Renew item"
    authorize! :read, :inventory
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
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Sell to IDeATe student"
    @title = "Sell to IDeATe student"
    authorize! :manage, :legacy_lending
  end

  def sale_course
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Sell to course- or project-funded account"
    @title = "Sell to course- or project-funded account"
    authorize! :manage, :legacy_lending
  end

  def sale_student_return
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
    session['card_andrewid'] = nil

    @header = "Return from IDeATe student"
    @title = "Return from IDeATe student"
    authorize! :manage, :legacy_lending
  end

  def sale_course_return
    @card_andrewid = session[:card_andrewid]
    @card_person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
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
    @header = "#{ view_context.link_to 'Schedules', schedule_index_path } <small>Course delivery schedule</small>".html_safe()
    @title = "Course delivery schedule"
    authorize! :manage, :legacy_lending
  end

  def scan_input
    scan_input = params[:scan_input]
    unless scan_input.nil? || scan_input.empty?
      card_andrewid = card_lookup(scan_input)
      if card_andrewid.present?
        session['card_andrewid'] = card_andrewid
        logger.info "Scanned card for Andrew user '#{card_andrewid}' from #{params[:scan_input_redirect_action]} at #{Time.now}"
      elsif params[:card_input_only] == "0"
        session['scan_input'] = scan_input
        logger.info "Scanned item '#{scan_input}' from #{params[:scan_input_redirect_action]} at #{Time.now}"
      else
        flash['alert'] = 'Invalid card ID.'
        logger.info "Scanned card for invalid Andrew user from #{params[:scan_input_redirect_action]} at #{Time.now}"
      end
      redirect_to action: params[:scan_input_redirect_action]
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


end
