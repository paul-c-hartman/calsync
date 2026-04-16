# typed: false

class FlowTransformsController < ApplicationController
  before_action :set_flow_transform, only: %i[ show edit update destroy ]

  # GET /flow_transforms or /flow_transforms.json
  def index
    @flow_transforms = FlowTransform.all
  end

  # GET /flow_transforms/1 or /flow_transforms/1.json
  def show
  end

  # GET /flow_transforms/new
  def new
    @flow_transform = FlowTransform.new
  end

  # GET /flow_transforms/1/edit
  def edit
  end

  # POST /flow_transforms or /flow_transforms.json
  def create
    @flow_transform = FlowTransform.new(flow_transform_params)

    respond_to do |format|
      if @flow_transform.save
        format.html { redirect_to @flow_transform, notice: "Flow transform was successfully created." }
        format.json { render :show, status: :created, location: @flow_transform }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flow_transform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flow_transforms/1 or /flow_transforms/1.json
  def update
    respond_to do |format|
      if @flow_transform.update(flow_transform_params)
        format.html { redirect_to @flow_transform, notice: "Flow transform was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @flow_transform }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flow_transform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flow_transforms/1 or /flow_transforms/1.json
  def destroy
    @flow_transform.destroy!

    respond_to do |format|
      format.html { redirect_to flow_transforms_path, notice: "Flow transform was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_transform
      @flow_transform = FlowTransform.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def flow_transform_params
      params.fetch(:flow_transform, {})
    end
end
