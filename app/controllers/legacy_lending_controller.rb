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

    end

    @header = "Lend Item"
    @title = "Lend Item"
    authorize! :manage, :legacy_lending
  end

  def student_purchase
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
      @card_andrewid = CarnegieMellonIDCard.get_andrewid_by_card_id(card_id)
      session['card_andrewid'] = @card_andrewid
      redirect_to '/lending/lend'
    end

  end

end
