require 'bundler/inline'
require 'sinatra/base'
require 'uri'

class EmbedToolApp < Sinatra::Base
  set :mount_point, '/embed-tool'

  before do
    headers 'X-Frame-Options' => "ALLOW-FROM *"
  end

  get '/' do
    headers 'Content-Type' => 'text/xml'
    erb :lti_config, :layout => false
  end

  post '/' do
    redirect params['custom_url'].strip
  end
end

run EmbedToolApp
