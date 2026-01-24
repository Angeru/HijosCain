class MemberConfirmationController < ApplicationController
    layout: false
    def qr
      @user = User.find_by_id(params[:id])
    end
  end