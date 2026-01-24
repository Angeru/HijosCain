class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy churn dechurn ]

  def index
    @members = Member.all.paginate(page: params[:page], per_page: 10)
    @filter = params[:filter] || "all"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :surnames, :signup_date, :churn_date,)
    end
end