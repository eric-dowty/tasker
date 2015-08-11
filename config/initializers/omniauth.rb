Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GIT_KEY'], ENV['GIT_SECRET_KEY']
end
