# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
    def create
        @person = Person.find(params[:person_id])
        @comment = Comment.new(comment_params)
        @comment.church = current_user.church
        @comment.person = @person
        @comment.user = current_user
        if @comment.save
            redirect_to edit_person_path(@person)
        else
            render 'person/edit'
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
