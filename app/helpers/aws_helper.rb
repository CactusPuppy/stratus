module AwsHelper
  def get_users
    $iam_client.list_users
  end
end
