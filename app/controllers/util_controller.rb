class UtilController < ApplicationController
    layout '/util/layouts'
    
    def balancer
        if user_signed_in?
            redirect_to groups_path
        else
            redirect_to landing_path
        end
    end
    
    def index
    end
    
    def landing
        render layout: false
    end
end
