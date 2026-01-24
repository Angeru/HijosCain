class MenuController < ApplicationController
  def main
    @total_members = 0
    @debt_members = 0
    @no_debt_members = 0

    @storage = 0
    @low_stock = 0
  end
end