HnApi::Application.routes.draw do

  api_version(:module => "v1", :header => {:name => "Accept",
                               :value => "application/vnd.labs.gertig.com; version=1"},
                               :parameter => {:name => "version", :value => "v1"}) do

    match '/hn' => 'hn#index', :via => :get # /hn?version=v1 OR use the Accept header
  end

end
