require 'bundler/setup'
require 'wolf_core'
require 'uri'

class EmbedToolApp < WolfCore::App
  set :title, 'Embed Tool'
  set :root, File.dirname(__FILE__)

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

  get '/generate-config' do
    slim :generate_config
  end

  post '/generate-config' do
    if !params['url'].match(/^#{URI::regexp(%w(http https))}$/)
      flash[:danger] = "Invalid embed URL"
      redirect "#{mount_point}/generate-config"
    else
      query_params = ["url=#{params['url']}"]
      ['course_navigation', 'account_navigation', 'user_navigation'].each do |opt|
        query_params << "#{opt}=true" if params[opt]
      end

      redirect "#{mount_point}?#{query_params.join('&')}"
    end
  end
end
