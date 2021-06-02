class ApplicationController < ActionController::Base
    private
    def editor_only
        unless current_user.editor? || current_user.admin?
            flash[:notice] = "Esta de vivo #{current_user.email}"
            redirect_to root_path 
        end
    end
end
