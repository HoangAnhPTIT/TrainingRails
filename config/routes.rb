Rails.application.routes.draw do
  namespace 'api' do
    resources :players
    resources :games
    post '/games/:gameid/score', to: 'games#score'
    delete '/games/:gameid/reset_point', to: 'games#reset_point'
    put '/games/:gameid/end', to: 'games#end_game'
    get '/leaderboard', to: 'games#leaderboard'
  end
end
