# frozen_string_literal: true

class BoardsController < ApplicationController
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
    board = BoardCreator
            .new(current_account)
            .perform(attrs: permitted_params, owner: current_user)

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

  def lanes_data_serialized
    LaneSerializer.new(board.ordered_alive_lanes, include: [:ordered_alive_cards]).as_json
  end
end
