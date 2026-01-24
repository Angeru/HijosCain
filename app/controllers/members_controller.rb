class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy churn dechurn ]

  def index
    @members = Member.all.paginate(page: params[:page], per_page: 10)
    @filter = params[:filter] || "all"
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to members_path, notice: "Miembro actualizado." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: "Miembro creado." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:address, :birth_date, :churn_date, :city, :zip_code, :phone, :document_number, :first_name, :surname, :join_date, :province,:user_name, :email, :password, :role, :number)
   
   
   
   
   
    end
end