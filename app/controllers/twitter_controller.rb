class TwitterController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless TwitterOauthSetting.find_by_user_id(current_user.id).nil?
      redirect_to '/twitter_profile'
    end
  end

  def generate_twitter_oauth_url
    oauth_callback = "http://#{request.host}:#{request.port}/oauth_account"

    consumer = get_consumer
    puts "\n\n\nOAuth consumer response: #{consumer.inspect}\n\n\n"

    request_token = consumer.get_request_token(:oauth_callback => oauth_callback)
    puts "\n\n\nOAuth request_token: #{request_token.inspect}\n\n\n"

    session[:request_token] = request_token
    redirect_to request_token.authorize_url(:oauth_callback => oauth_callback)
  end

  def oauth_account
    if TwitterOauthSetting.find_by_user_id(current_user.id).nil?
      token  = session[:request_token]['token']
      secret = session[:request_token]['secret']

      halt 400 unless token and secret
      session[:request_token] = nil

      request_token = OAuth::RequestToken.from_hash(get_consumer,
                                                    :oauth_token => token,
                                                    :oauth_token_secret => secret)

      puts "\nrequest_token: #{request_token.token}\n"
      puts "\nrequest_secret: #{request_token.secret}\n"

      access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])


      #@access_token = @request_token.get_access_token(:oauth_verifier => params['oauth_verifier'])
      #TwitterOauthSetting.create(atoken: @access_token.token, asecret: @access_token.secret, user_id: current_user.id)
      puts "\naccess_token: #{access_token.token}\n"
      puts "\naccess_secret: #{access_token.secret}\n"
      TwitterOauthSetting.create(atoken: access_token.token, asecret: access_token.secret, user_id: current_user.id)
      update_user_account()
    end
    redirect_to '/twitter_profile'
  end

  def twitter_profile
    client = get_client
    puts "\n\n\nTwitter client methods:"
    puts "\n"
    puts client.methods.sort.inspect
    puts "\n"
    puts client.mentions_timeline.inspect
    puts "\n"
    puts client.friends.inspect
    puts "\n"
    puts client.followers.inspect
    puts "\n"
    puts client.following.inspect
    puts "\n\n\n"
    @user_timeline = client.user_timeline
    @home_timeline = client.home_timeline
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def twitter_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :name, :screen_name,
                                 :url, :profile_image_url, :location, :description)
  end

  def get_consumer
    OAuth::Consumer.new('GGyNQSOfqRv3Z8dmt9JldBtcw',
                        '8O5N62pvP60ShHyZKkWocYXDluzWwlJQ5bf0dAoXsxhLbBtSRh',
                        :site => 'https://api.twitter.com')
  end


  def get_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = 'GGyNQSOfqRv3Z8dmt9JldBtcw'
      config.consumer_secret     = '8O5N62pvP60ShHyZKkWocYXDluzWwlJQ5bf0dAoXsxhLbBtSRh'
      config.access_token        = TwitterOauthSetting.find_by_user_id(current_user.id).atoken
      config.access_token_secret = TwitterOauthSetting.find_by_user_id(current_user.id).asecret
    end
  end

  def update_user_account
    user_twitter_profile = get_client.user
    current_user.update_attributes({
                                       name: user_twitter_profile.name,
                                       screen_name: user_twitter_profile.screen_name,
                                       url: user_twitter_profile.url,
                                       profile_image_url: user_twitter_profile.profile_image_url,
                                       location: user_twitter_profile.location,
                                       description: user_twitter_profile.description
                                   })
  end
end
