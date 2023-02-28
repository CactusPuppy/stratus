class TestController < ApplicationController
  def list_users
    respond_to do |format|
      format.json {
        render json: $iam_client.list_users
      }
    end
  end
end
