When /^I retrieve username and password from subscriptions file/ do
  eval(File.open('subscriptions').read)
  @username = RallyUtils::SUBSCRIPTIONS[:admin_username]
  @password = RallyUtils::SUBSCRIPTIONS[:admin_password]
end

And /^I log into ALM as admin/ do
  @cookie = RallyUtils.login(@username, @password)
end

And /^I use the credentials user (.*) with password (.*)/ do |username, password|
  @credentials = {:username => username, :password => password}
end

Then /^I can create a subscription with admin username (.*?) and modules (.*)$/ do |admin_user, modules|
  @subscription_id = RallyUtils.create_subscription(@cookie, admin_user, modules.split('|'))
end

Then /^I can toggle on (.*)$/ do |toggles|
  RallyUtils.switch_toggles(@cookie, @subscription_id, toggles.split('|'))
end

Then /^I can retrieve an artifact name for (.*)$/ do |artifact_id|
  @artifact_name = RallyUtils.get_artifact_name(@credentials[:username], @credentials[:password], artifact_id)
end