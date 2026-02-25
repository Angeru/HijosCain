class GoodTypesController < ApplicationController
  before_action :require_role
  before_action :set_good_type, only: %i[edit update destroy]

  def index
    @good_types = GoodType.order(:name)
  end

  def new
    @good_type = GoodType.new
  end

  def create
    @good_type = GoodType.new(good_type_params)

    respond_to do |format|
      if @good_type.save
        format.html { redirect_to good_types_path, notice: "Tipo creado correctamente." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @good_type.update(good_type_params)
        format.html { redirect_to good_types_path, notice: "Tipo actualizado correctamente." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @good_type.goods.any?
      redirect_back fallback_location: good_types_path, alert: "No se puede eliminar el tipo porque tiene artículos asociados."
    else
      @good_type.destroy!
      redirect_to good_types_path, notice: "Tipo eliminado.", status: :see_other
    end
  end

  private

  def set_good_type
    @good_type = GoodType.find(params[:id])
  end

  def good_type_params
    params.require(:good_type).permit(:name)
  end
end
