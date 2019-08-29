# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :require_login

  before_action :xhr_only!, only: %i[edit update]

  def index
    render locals: { accounts: current_user.accounts.personal_order(current_user.id).alive }
  end

  def edit
    render locals: { account: account }, layout: false
  end

  def update
    account.update! permitted_params

    # TODO: Pass back url in parameters for redirection
    redirect_to accounts_url(subomain: account.subdomain), notice: flash_t
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { account: e.record }, layout: false
  end

  private

  def account
    @account ||= current_user.accounts.find params[:id]
  end

  def permitted_params
    params.require(:account).permit(:name, :subdomain)
  end
end
