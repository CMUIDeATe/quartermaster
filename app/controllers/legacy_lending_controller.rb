class LegacyLendingController < ApplicationController

  def index
    @header = "Lend and Return Items"
    @title = "Lend and Return Items"
    authorize! :manage, :legacy_lending
  end

  def lend
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

end
