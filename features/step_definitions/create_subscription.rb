When /^I retrieve username and password from subscriptions file/ do
  eval(File.open('subscriptions').read)
  @username = RallyUtils::SUBSCRIPTIONS[:admin_username]
  @password = RallyUtils::SUBSCRIPTIONS[:admin_password]
end

And /^I log into ALM/ do
  @cookie = RallyUtils.login(@username, @password)
end

Then /^I can create a subscription with admin username (.*?) and modules (.*)$/ do |admin_user, modules|
  @subscription_id = RallyUtils.create_subscription(@cookie, admin_user, modules.split('|'))
end

Then /^I can toggle on (.*)$/ do |toggles|
  RallyUtils.switch_toggles(@cookie, @subscription_id, toggles.split('|'))
end
When /^I prompt for an artifact_id$/ do
  @artifact_id = RallyUtils.prompt_for_artifact_id
end
When /^I get "([^"]*)" from stdin$/ do |artifact_id|
  $stdin << artifact_id
end

Then /^I can retrieve an artifact name using the artifact_id$/ do
  @artifact_name = RallyUtils.get_artifact_name(@cookie, admin_user, modules.split('|'))
end