# typed: false

class FlowFiltersController < ApplicationController
  before_action :set_flow_filter, only: %i[ show edit update destroy ]

  # GET /flow_filters or /flow_filters.json
  def index
    @flow_filters = FlowFilter.all
  end

  # GET /flow_filters/1 or /flow_filters/1.json
  def show
  end

  # GET /flow_filters/new
  def new
    @flow_filter = FlowFilter.new
  end

  # GET /flow_filters/1/edit
  def edit
  end

  # POST /flow_filters or /flow_filters.json
  def create
    @flow_filter = FlowFilter.new(flow_filter_params)

    respond_to do |format|
      if @flow_filter.save
        format.html { redirect_to @flow_filter, notice: "Flow filter was successfully created." }
        format.json { render :show, status: :created, location: @flow_filter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flow_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flow_filters/1 or /flow_filters/1.json
  def update
    respond_to do |format|
      if @flow_filter.update(flow_filter_params)
        format.html { redirect_to @flow_filter, notice: "Flow filter was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @flow_filter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flow_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flow_filters/1 or /flow_filters/1.json
  def destroy
    @flow_filter.destroy!

    respond_to do |format|
      format.html { redirect_to flow_filters_path, notice: "Flow filter was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_filter
      @flow_filter = FlowFilter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def flow_filter_params
      params.fetch(:flow_filter, {})
    end
end
