class LegacyLendingController < ApplicationController

  def index
    @header = "Lend and Return Items"
    @title = "Lend and Return Items"
    authorize! :manage, :legacy_lending
  end

  def lend
    @card_andrewid = session[:card_andrewid]
    session['card_andrewid'] = nil

    unless @card_andrewid.nil? || @card_andrewid.empty?
      begin
        person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
        @card_name = "#{person['sn']}, #{person['givenName']}"
      rescue
        @card_name = ''
      end
    end

    @header = "Lend Item"
    @title = "Lend Item"
    authorize! :manage, :legacy_lending
  end

  def student_purchase
    @card_andrewid = session[:card_andrewid]
    session['card_andrewid'] = nil

    unless @card_andrewid.nil? || @card_andrewid.empty?
      begin
        person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
        @card_name = "#{person['sn']}, #{person['givenName']}"
      rescue
        @card_name = ''
      end
    end

    @header = "Manage Purchases by IDeATe Students"
    @title = "Manage Purchases by IDeATe Students"
    authorize! :manage, :legacy_lending
  end

  def external_purchase
    @header = "Manage Purchases by Faculty, Staff, and Non-IDeATe Students"
    @title = "Manage Purchases by Faculty, Staff, and Non-IDeATe Students"
    authorize! :manage, :legacy_lending
  end

  def course_purchase
    @card_andrewid = session[:card_andrewid]
    session['card_andrewid'] = nil

    unless @card_andrewid.nil? || @card_andrewid.empty?
      begin
        person = CarnegieMellonPerson.find_by_andrewid(@card_andrewid)
        @card_name = "#{person['sn']}, #{person['givenName']}"
      rescue
        @card_name = ''
      end
    end

    @header = "Manage Purchases Funded by a Course or Project"
    @title = "Manage Purchases Funded by a Course or Project"
    authorize! :manage, :legacy_lending
  end

  def pc_cart
    @header = "PC Cart Schedule"
    @title = "PC Cart Schedule"
    authorize! :manage, :legacy_lending
  end

  def schedule
    @header = "Shift Schedule"
    @title = "Shift Schedule"
    authorize! :manage, :legacy_lending
  end

  def nvbots
    @header = "NVBots Live Feed"
    @title = "NVBots Live Feed"
    authorize! :manage, :legacy_lending
  end

  def card_input
    card_id = params[:card_input]
    unless card_id.nil? || card_id.empty?
      @card_andrewid = card_lookup(card_id)
      if @card_andrewid.nil?
        flash['alert'] = 'Invalid card ID.'
        logger.info "Logged card for invalid Andrew user from #{params[:card_input_redirect]} at #{Time.now}"
      else
        logger.info "Logged card for Andrew user '#{@card_andrewid}' from #{params[:card_input_redirect]} at #{Time.now}"
      end
      session['card_andrewid'] = @card_andrewid
      redirect_to action: params[:card_input_redirect]
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

end
