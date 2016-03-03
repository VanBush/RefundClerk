class RefundRequestsController < ApplicationController
  def index
    authorize RefundRequest
    @refund_requests = policy_scope(RefundRequest)
    @refund_requests.select! { |r| r.user_id == params[:user_id] } if params[:user_id].present?
    @refund_requests.select! { |r| r.category_id == params[:category_id] } if params[:category_id].present?
    @refund_requests
  end

  def show
    @refund_request = RefundRequest.find(params[:id]).decorate
    authorize @refund_request
  end

  def new
    @refund_request = RefundRequest.new
    authorize @refund_request
    @refund_request.user = current_user
  end

  def create
    @refund_request = RefundRequest.new(user: current_user)
    authorize @refund_request
    @refund_request.assign_attributes(permitted_attributes(@refund_request))
    if @refund_request.save
      redirect_to refund_request_path(@refund_request),
                  notice: 'Refund request has been created'
    else
      render :new, flash: { error: 'Refund request could not be created' }
    end
  end

  def edit
    @refund_request = RefundRequest.find(params[:id]).decorate
    authorize @refund_request
  end

  def update
    @refund_request = RefundRequest.find(params[:id]).decorate
    authorize @refund_request
    if @refund_request.update_attributes(permitted_attributes(@refund_request))
      render :show, notice: 'Refund request has been updated'
    else
      render :new, flash: { error: 'Refund request could not be updated' }
    end
  end

  def destroy
    @refund_request = RefundRequest.find(params[:id])
    authorize @refund_request
    if @refund_request.destroy
      redirect_to refund_requests_path, notice: 'Refund request has been deleted'
    else
      redirect_to refund_request_path(@refund_request),
                  flash: { error: 'Refund request could not be deleted' }
    end
  end

end
