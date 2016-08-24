class LegacyLendingController < ApplicationController

  def index
    @header = "Lending"
    @title = "Lending"
    authorize! :manage, :legacy_lending
  end

  def search
    @header = "Search Lending"
    @title = "Search Lending"
    authorize! :manage, :legacy_lending
  end

  def lend
    @header = "Lend Item"
    @title = "Lend Item"
    authorize! :manage, :legacy_lending
  end

  def return
    @header = "Return Item"
    @title = "Return Item"
    authorize! :manage, :legacy_lending
  end

  def course_lend
    @header = "Lend Item for Course"
    @title = "Lend Item for Course"
    authorize! :manage, :legacy_lending
  end

  def student_purchase
    @header = "Manage Student Purchases"
    @title = "Manage Student Purchases"
    authorize! :manage, :legacy_lending
  end

  def course_purchase
    @header = "Manage Course Purchases"
    @title = "Manage Course Purchases"
    authorize! :manage, :legacy_lending
  end

  def cube_cartridge
    @header = "Manage Cube Cartridges"
    @title = "Manage Cube Cartridges"
    authorize! :manage, :legacy_lending
  end

end
