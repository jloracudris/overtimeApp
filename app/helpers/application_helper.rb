module ApplicationHelper
    def active?(path)
        "active" if current_page?(path)
    end

    def flash_class(level)
        case level
            when 'notice' then "alert alert-info alert-dismissible fade show"
            when 'success' then "alert alert-success alert-dismissible fade show"
            when 'error' then "alert alert-danger alert-dismissible fade show"
            when 'alert' then "alert alert-error alert-dismissible fade show"
        end
    end
end
