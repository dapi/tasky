# frozen_string_literal: true

class BoardsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :xhr_only!, only: %i[new create edit update]

  # TODO: Move to BoardMemberships
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
    render locals: { data: lanes_data_serialized, board: board }
  end

  def new
    render locals: { board: Board.new(permitted_params.reverse_merge(title: t('.default_title'))) }, layout: false
  end

  def edit
    render locals: { board: board }, layout: false
  end

  # rubocop:disable Metrics/AbcSize
  def update
    board.update! permitted_params

    respond_to do |format|
      format.html { redirect_to board_url(board), notice: flash_t }
      format.json { respond_with_bip board }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html do
        flash.alert = e.message
        render :edit, locals: { board: e.record }, layout: false
      end
      format.json { respond_with_bip board }
    end
  end

  def create
    account = current_user.accounts.find(permitted_params[:account_id])
    board = BoardCreator
            .new(account)
            .perform(attrs: permitted_params, owner: current_user)

    redirect_to board_url(board), notice: flash_t
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :new, locals: { board: e.record }, layout: false
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    board.destroy!
    redirect_to accounts_path, notice: flash_t
  end

  def archive
    board.archive!
    redirect_to accounts_path, notice: flash_t
  end

  private

  def board
    @board ||= current_user.available_boards.find params[:id]
  end

  def permitted_params
    params.require(:board).permit(:title, :account_id)
  end

  def lanes_data_serialized
    LaneSerializer.new(board.ordered_alive_lanes, include: [:ordered_alive_cards]).as_json
  end
end
