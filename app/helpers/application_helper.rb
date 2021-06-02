module ApplicationHelper
    def check_editor_admin
        user_signed_in? && (current_user.editor? || current_user.admin?)
    end
end
