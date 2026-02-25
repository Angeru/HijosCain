class QuotesController < ApplicationController
    before_action :require_president_or_treasurer
    before_action :set_quote, only: %i[ show edit update destroy generate_charges]
  
    # GET /quotes or /quotes.json
    def index
      @quotes = Quote.all.paginate(page: params[:page], per_page: 10)
    end
  
    # GET /quotes/1 or /quotes/1.json
    def show
    end
  
    # GET /quotes/new
    def new
      @quote = Quote.new
    end
  
    # GET /quotes/1/edit
    def edit
    end
  
    def generate_charges
      Member.active.each do |member|
        unless member.charges.where(quote_id: @quote.id).any?
          Charge.create(
            member: member,
            quote:   @quote,
            notes:   @quote.description
          )
        end
      end
  
       redirect_to @quote, notice: "Deudas creadas."
    end
  
    # POST /quotes or /quotes.json
    def create
      @quote = Quote.new(quote_params)
  
      respond_to do |format|
        if @quote.save
          format.html { redirect_to @quote, notice: "Quote was successfully created." }
          format.json { render :show, status: :created, location: @quote }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /quotes/1 or /quotes/1.json
    def update
      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to @quote, notice: "Quote was successfully updated." }
          format.json { render :show, status: :ok, location: @quote }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /quotes/1 or /quotes/1.json
    def destroy
      @quote.destroy!
  
      respond_to do |format|
        format.html { redirect_to quotes_path, status: :see_other, notice: "Quote was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_quote
        @quote = Quote.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def quote_params
        params.require(:quote).permit(:description, :amount, :notes, :start_date, :end_date)
      end
  end
  