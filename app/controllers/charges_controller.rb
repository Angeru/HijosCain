class ChargesController < ApplicationController
  before_action :require_president_or_treasurer
  before_action :set_charge

  def pay
    @charge.update!(charge_date: Date.today)
    redirect_to @charge.quote, notice: "Pago registrado."
  end

  def unpay
    @charge.update!(charge_date: nil)
    redirect_to @charge.quote, notice: "Pago deshecho."
  end

  private

  def set_charge
    @charge = Charge.find(params[:id])
  end
end
