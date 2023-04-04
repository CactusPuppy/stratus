class RoleRequestsController < ApplicationController
  before_action only: [:approve, :reject] do
    unless current_user.manager?
      flash[:error] = "You are not permitted to perform that action"
      redirect_to role_requests_path
      return
    end

    @role_request = RoleRequest.find(params[:role_request_id])
    unless @role_request
      flash[:error] = "Request ##{params[:role_request_id]} not found"
      redirect_to role_requests_path
      return
    end
  end

  def index
    redirect_to new_session_path unless current_user
    if @current_user.manager?
      @role_requests = RoleRequest.where(request_state: :submitted)
    else
      @role_requests = RoleRequest.where(requester_user: @current_user, request_state: :submitted).includes(:requester_user)
    end

    @approved_role_requests = RoleRequest.where(requester_user: @current_user, request_state: [:completed]).includes(:requester_user, :approver_user)
    @rejected_role_requests = RoleRequest.where(requester_user: @current_user, request_state: [:rejected]).includes(:requester_user, :approver_user)
  end

  def new
    redirect_to new_session_path unless current_user
    @role_request = RoleRequest.new
  end

  def create
    redirect_to new_session_path and return unless current_user
    request = RoleRequest.create(requester_user: @current_user, request_state: :submitted,
      requested_template_id: params[:role_request][:requested_template_id], description: params[:role_request][:description])
    unless request.save
      flash[:error] = "Creating request failed"
      redirect_to new_role_request_path
      return
    end

    flash[:notice] = "Request submitted"
    redirect_to role_requests_path
  end

  def approve
    # TODO: Perform role update on AWS IAM
    # user = Aws::IAM::User.new(current_user.username, $iam_client)
    # return if (user.blank?)
    # role = Aws::IAM::Policy

    response = $iam_client.put_user_policy({
      policy_document: {
        Version: "2012-10-17",
        Statement: [{
          Effect: "Allow",
          Action: "sts:AssumeRole",
          Resource: "arn:aws:iam::554454578278:role/RDSEmployeeRead"
        }]
      }.to_json,
      policy_name: "Stratus_#{ {1 => "RDSReadOnly"}[@role_request.requested_template_id] }",
      user_name: "employee1"
    })

    unless response
      flash[:error] = "No response from AWS, failed to process your request"
      redirect_to role_requests_path
      return
    end

    @role_request.request_status = :completed
    @role_request.approver_user = @current_user
    @role_request.save

    flash[:notice] = "Request ##{@role_request.id} approved"
    redirect_to role_requests_path
  end

  def reject

    @role_request.request_status = :rejected
    @role_request.approver_user = @current_user
    @role_request.save

    flash[:notice] = "Request ##{@role_request.id} rejected"
    redirect_to role_requests_path
  end
end
