Rails.application.routes.draw do
  get 'notifications/notify'
  post 'notifications/notify' => 'notifications#notify'
  get 'notifications/text_assignment'
  # post 'notifications/text_assignment'
  get 'reports/email_assignment_sent'

  resources :notes
  namespace :admin do
    resources :coaches
resources :conversations
resources :messages
resources :users

    root to: "coaches#index"
  end




  resources :messages
  resources :conversations
  resources :coaches
  resources :users
  resources :form_steps
  get 'abouts/terms'

root 'abouts#welcome'
get 'abouts/welcome'
get 'abouts/aboutus'
get 'abouts/ourcoaches'
get 'abouts/testimonials'
get 'abouts/signupconfirmation'
get 'survey' => 'abouts#survey'
get 'our_picks' => 'abouts#survey_results'


  get 'sessions/login'
  post 'sessions/login'

  get 'sessions/signup'
  post 'sessions/signup'

  get 'sessions/logout'
  post 'sessions/logout'

  get 'reports/write_email'
  post 'reports/send_email'
  get 'reports/send_confirmation'
  post 'reports/send_confirmation'

  get 'reports/coaches_assigner'
  post 'reports/coaches_assigner'
  get 'reports/send_assignment'
  post 'reports/send_assignment'





  get 'teams/index'

  get 'menu/welcome'
  get 'menu/community'
  get 'menu/inspiration'
  get 'menu/support'




  post 'charges/index'
  post 'charges/new'
  resources :charges




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
