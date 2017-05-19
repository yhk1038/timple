class UtilController < ApplicationController
    layout '/util/layouts'
    
    def index
        redirect_to table_path if user_signed_in?
    end
    
    def landing
        redirect_to table_path if user_signed_in?
        
        render layout: false
    end
end
