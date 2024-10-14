class TransactionController < ApplicationController
  before_action :authenticate!

  def create
    body = params.require(:transaction).permit(:amount, :from_id, :to_id)
    transfer_amount = body['amount']
    from_id = body['from_id']
    to_id = body['to_id']

    # Validate amount
    if transfer_amount < 0
      return render json: {error: 'amount must be greater than 0'}, status: :bad_request
    end

    # get current user
    cuser = current_user
    user = User.find_by(id=cuser[:id])
    unless user
      return render json: {error: 'invalid user'}, status: :not_found
    end

    begin
      ActiveRecord::Base.transaction do
        from_wallet = UserWallet.lock.find_by(id:from_id, user_id: user.id)
        unless from_wallet
          return render json: {error: 'cannot find any specific wallet'}, status: :bad_request
        end

        # check wallet balance
        if from_wallet.balance < transfer_amount
          return render json: {error: 'your wallet balance is not sufficient'}, status: :bad_request
        end

        # Check target user wallet
        target_wallet = UserWallet.lock.find_by(id:to_id)
        unless target_wallet
          return render json: {error: 'your target cannot be found'}, status: :bad_request
        end

        # create record
        trf_amount = transfer_amount * -1
        from_wallet.send_transactions.create!(amount: trf_amount, to_id: target_wallet.id, status: Transaction::STATUS_DONE, trx_type: Transaction::TRX_TYPE_TRANSFER)
        target_wallet.receive_transactions.create!(amount: transfer_amount, from_id: from_wallet.id, status: Transaction::STATUS_DONE, trx_type: Transaction::TRX_TYPE_DEPOSIT)

        from_wallet.update!(balance: from_wallet.balance + trf_amount)
        target_wallet.update!(balance: target_wallet.balance + transfer_amount)
      end
    rescue ActiveRecord::RecordInvalid => e
      return render json: {error: "error when move the balance #{e.message}"}
    end

    render json: {'status': 'success'}, status: :ok
  end

end
