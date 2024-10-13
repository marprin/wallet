class TransactionController < ApplicationController
  before_action :authenticate!

  def create
    render json: {'trx': 'abc'}
  end

end
