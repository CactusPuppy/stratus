class TestController < ApplicationController
  def list_users
    respond_to do |format|
      format.json {
        render json: {
          user_data: $iam_client.get_user({user_name: "employee1"}),
          user_policies: $iam_client.list_user_policies({ user_name: "employee1" })
        }
      }
    end
  end

  def clear_employee1
    $iam_client.delete_user_policy({
      policy_name: "Stratus_RDSReadOnly",
      user_name: "employee1"
    })
    respond_to do |format|
      format.json {
        render json: {
          user_data: $iam_client.get_user({user_name: "employee1"}),
          user_policies: $iam_client.list_user_policies({ user_name: "employee1" })
        }
      }
    end
  end
end
