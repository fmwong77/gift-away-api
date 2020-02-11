class HomeController < ApplicationController
    def index
        # redirect_to :file => 'public/index.html'
        redirect_to 'http://localhost:3001/home'
    end
end