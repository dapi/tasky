# frozen_string_literal: true

class BoardMembershipsController < ApplicationController
  def destroy
    # TODO Restrict self destroing!
    #
    membership = BoardMembership.find params[:id]
    # TODO Authorize
    membership.destroy!
  end
end
