module AwsHelper
  # Creates an inline policy for a user that lets the user assume a role.
  #
  # @param policy_name [String] The name to give the policy.
  # @param user [Aws::IAM::User] The user that owns the policy.
  # @param role [Aws::IAM::Role] The role that can be assumed.
  # @return [Aws::IAM::UserPolicy] The newly created policy.
  def create_user_policy(policy_name, user, role)
    policy = user.create_policy(
      policy_name: policy_name,
      policy_document: {
        Version: "2012-10-17",
        Statement: [{
          Effect: "Allow",
          Action: "sts:AssumeRole",
          Resource: role.arn
        }]
      }.to_json)
    puts("Created an inline policy for #{user.name} that lets the user assume role #{role.name}.")
  rescue Aws::Errors::ServiceError => e
    puts("Couldn't create an inline policy for user #{user.name}. Here's why: ")
    puts("\t#{e.code}: #{e.message}")
    raise
  else
    policy
  end
end
