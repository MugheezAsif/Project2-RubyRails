# class FeaturesController
class FeaturesController < ApplicationController
  before_action :find_plan
  before_action :set_feature, only: %i[show edit update destroy]
  before_action :check_admin
  # GET /features/1 or /features/1.json
  def show; end

  # GET /features/new
  def new
    @feature = @plan.features.build
  end

  # GET /features/1/edit
  def edit; end

  # POST /features or /features.json
  def create
    @feature = @plan.features.build(feature_params)
    @feature.save
    redirect_to plan_path(@plan)
  end

  # PATCH/PUT /features/1 or /features/1.json
  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to plan_feature_path(@plan), notice: 'Feature was successfully updated.' }
        format.json { render :show, status: :ok, location: @feature }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1 or /features/1.json
  def destroy
    @feature = @plan.features.find(params[:id])
    @feature.destroy
    redirect_to plan_path(@plan)
  end

  private

  def find_plan
    @plan = Plan.find(params[:plan_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_feature
    @feature = @plan.features.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_limit, :plan_id)
  end

  def check_admin
    if user_signed_in?
      if current_user.user_type == 'Buyer'
        responder('Only admin can add a feature.')
      else
        return if @plan.user_id == current_user.id

        responder('You can only add features to your own plans.')
      end
    else
      responder('Sign in to add or edit a feature.')
    end
  end

  def responder(message)
    respond_to do |format|
      format.html { redirect_to plans_url, notice: message }
      format.json { head :no_content }
    end
  end
end
