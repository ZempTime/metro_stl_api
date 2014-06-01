Rails.application.routes.draw do
  get '/:stop1/:stop2/:delay', to: 'response#v1_calculate'
  root to: 'response#index'
end





# http://localhost:3000/SHREWSBURY/FOREST%20PARK/15
