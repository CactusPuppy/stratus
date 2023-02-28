class RoleRequestsController < ApplicationController
  def index
    redirect_to new_session_path unless current_user
    if @current_user.manager?
      @role_requests = RoleRequest.where(request_state: :submitted)
    else
      @role_requests = RoleRequest.where(requester_user: @current_user, request_state: :submitted).includes(:requester_user)
    end
  end

  def new
    redirect_to new_session_path unless current_user
    @role_request = RoleRequest.new
  end

  def create
    redirect_to new_session_path and return unless current_user
    request = RoleRequest.create(requester_user: @current_user, request_state: :submitted)
    binding.pry # DEBUG

    flash[:notice] = "Request submitted"
    redirect_to role_requests_path

    # FIXME: auto-approve
    approve
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
      policy_name: "Stratus_RDSReadOnly",
      user_name: "employee1"
    })
  end
end
