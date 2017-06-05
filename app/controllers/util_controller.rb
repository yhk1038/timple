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
    
    def mvp_v1
        @table_name = params[:table_key] || 'sample'
    end
end
