# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :require_login

  def users
    render locals: {
      props: {
        boardId: board.id,
        defaultUsers: board.members.map { |u| { value: u.id, label: u.public_name, avatar_url: u.avatar_url(size: 24) } },
        availableUsers: User.all.map { |u| { value: u.id, label: u.public_name, avatar_url: u.avatar_url(size: 24) } }
      }
    }
  end

  def index
    redirect_to accounts_url
  end

  def show
    render locals: { data: dashboard_data, board: board }
  end

  def new
    render locals: { board: Board.new }, layout: 'simple'
  end

  def edit
    render locals: { board: board }, layout: 'simple'
  end

  # rubocop:disable Metrics/AbcSize
  def update
    board.update! permitted_params

    respond_to do |format|
      format.html { redirect_to board_url(board, subdomain: current_account.subdomain), notice: flash_t }
      format.json { respond_with_bip board }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html do
        flash.alert = e.message
        render :edit, locals: { board: e.record }, layout: 'simple'
      end
      format.json { respond_with_bip board }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def create
    board = current_account.boards.create_with_member!(
      permitted_params,
      member: current_user
    )

    redirect_to board_url(board, subdomain: current_account.subdomain), notice: flash_t
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :new, locals: { board: e.record }, layout: 'simple'
  end

  def destroy
    board.destroy!
    redirect_to boards_path, notice: flash_t
  end

  def archive
    board.archive!
    redirect_to boards_path, notice: flash_t
  end

  private

  def board
    @board ||= current_user.available_boards.find params[:id]
  end

  def permitted_params
    params.require(:board).permit(:title)
  end

  def dashboard_data
    BoardPresenter.new(board, current_user).data
  end
end
