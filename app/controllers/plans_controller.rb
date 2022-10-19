# class PlansController
class PlansController < ApplicationController
  before_action :set_plan, only: %i[show edit update destroy]
  before_action :check_admin, only: %i[new create edit destroy]
  before_action :check_owner, only: %i[edit destroy]
  # GET /plans or /plans.json
  def index
    @plans = Plan.all.paginate(page: params[:page], per_page: 3)
  end

  # GET /plans/1 or /plans/1.json
  def show; end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit; end

  # POST /plans or /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.stripe_plan_id = Stripe::Product.create(name: @plan.name).id

    @plan.stripe_price_id = Stripe::Price.create({
      unit_amount: @plan.monthly_fee * 100,
      currency: 'usd',
      recurring: { interval: 'month' },
      product: @plan.stripe_plan_id }).id
    respond_to do |format|
      if @plan.save
        format.html { redirect_to plan_url(@plan), notice: "Plan was successfully created." }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to plan_url(@plan), notice: "Plan was successfully updated." }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_owner
    return if current_user.id == @plan.user_id

    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'You can only edit your own Plans.' }
      format.json { head :no_content }
    end
  end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, :user_id, :stripe_plan_id, :stripe_price_id)
  end

  def check_admin
    if user_signed_in?
      return if current_user.user_type == 'Admin'

      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'Only admin can create/edit/destroy Plans.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'Sign in to create or edit Plans.' }
      end
    end
  end
end
