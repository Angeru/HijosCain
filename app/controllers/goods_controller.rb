class GoodsController < ApplicationController
  before_action :require_role
  before_action :set_good, only: %i[show edit update destroy]

  def index
    @goods = Good.includes(:good_type).order(:nombre)
  end

  def show
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: "Artículo creado correctamente." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: "Artículo actualizado correctamente." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @good.destroy!
    redirect_to goods_path, notice: "Artículo eliminado.", status: :see_other
  end

  private

  def set_good
    @good = Good.find(params[:id])
  end

  def good_params
    params.require(:good).permit(:ean, :nombre, :good_type_id, :unidades, :notas, :cedido)
  end
end
