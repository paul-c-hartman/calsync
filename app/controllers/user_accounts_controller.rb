# typed: false

class UserAccountsController < ApplicationController
  before_action :set_user_account, only: %i[ show edit update destroy ]

  # GET /user_accounts or /user_accounts.json
  def index
    @user_accounts = UserAccount.all
  end

  # GET /user_accounts/1 or /user_accounts/1.json
  def show
  end

  # GET /user_accounts/new
  def new
    @user_account = UserAccount.new
  end

  # GET /user_accounts/1/edit
  def edit
  end

  # POST /user_accounts or /user_accounts.json
  def create
    @user_account = UserAccount.new(user_account_params)

    respond_to do |format|
      if @user_account.save
        format.html { redirect_to @user_account, notice: "User account was successfully created." }
        format.json { render :show, status: :created, location: @user_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_accounts/1 or /user_accounts/1.json
  def update
    respond_to do |format|
      if @user_account.update(user_account_params)
        format.html { redirect_to @user_account, notice: "User account was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_accounts/1 or /user_accounts/1.json
  def destroy
    @user_account.destroy!

    respond_to do |format|
      format.html { redirect_to user_accounts_path, notice: "User account was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_account
      @user_account = UserAccount.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_account_params
      params.fetch(:user_account, {})
    end
end
