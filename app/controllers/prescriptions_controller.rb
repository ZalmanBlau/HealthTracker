class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    @prescriptions = Prescription.all
  end

  # GET /prescriptions/1
  # GET /prescriptions/1.json
  def show
    puts "show page works!"
  end

  # GET /prescriptions/new
  def new
    @prescription = Prescription.new
  end

  def most_recent
    @prescription = Prescription.where("user_id = ?", current_user.id).last
    if @prescription.nil?
      render plain: "none"
    else
      render "show.json"
    end
  end

  def refill 
    @prescription = Prescription.where("user_id = ?", current_user.id).last
    if @prescription.used_refills < @prescription.refills 
      @prescription.remainder = @prescription.amount
      @prescription.used_refills += 1
      @prescription.save
    end
    render :plain => "ok!"
  end

  # GET /prescriptions/1/edit
  def edit
  end


  # POST /prescriptions
  # POST /prescriptions.json
  def create
    begin
    @prescription = Prescription.new
    params = prescription_params
    
    @prescription.name = params[:name]
    @prescription.amount = params[:amount]
    @prescription.dosage = params[:dosage]
    @prescription.refills = params[:refills]
    @prescription.remainder = params[:amount]
    @prescription.used_refills = 0
    puts "line 58 works"
    # @prescription.first_dose = (params["first_dose(4i)"].to_i * 60) + params["first_dose(5i)"].to_i
    puts "line 60 works"
    #converted to minutes

    @prescription.frequency = (params["frequency(4i)"].to_i * 60) + params["frequency(5i)"].to_i
    # Currently minutes and seconds, converted to seconds. Multiply by 60 to make it hours and minutes.
    puts "line 65 works"
    @prescription.user_id = current_user.id
    @prescription.save
    "line 68 works"
    respond_to do |format|
      if @prescription.save
        format.html { redirect_to @prescription, notice: 'Prescription was successfully created.' }
        format.json { render :show, status: :created, location: @prescription }
      else
        format.html { render :new }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    puts "something went wrong"
    puts e.message
  end
  end

  def reduce
    @prescription = Prescription.last
    rem = @prescription.remainder.to_i - @prescription.dosage.to_i
    @prescription.remainder = rem
    @prescription.save
    render "show.json"
  end

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescription }
      else
        format.html { render :edit }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescription_params
      params.require(:prescription).permit(:name, :first_dose, :amount, :used_refills, :refills, :dosage, :frequency, :user_id)
    end
end
