module CommentsHelper
    def recent_comments(person)
        comments = person.comments.all.order(created_at: :desc).limit(3).reverse
        render :partial => "comments/shortlist", :collection => comments, as: :comment
    end
end
