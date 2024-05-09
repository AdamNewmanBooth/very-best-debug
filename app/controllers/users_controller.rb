class UsersController < ApplicationController

  def index
    matching_users = User.all
    @users = matching_users.order(:created_at)

    render({ :template => "user_templates/all_users"})
  end
  
  def show
    username = params.fetch("username")
    matching_users = User.where({ :username => username })
    @user = matching_users.at(0)

    render({ :template => "user_templates/user_details"})
  end
  
  def create
    input_user = params.fetch("query_username")
    
    
    a_new_user = User.new
    a_new_user.username = input_user
    a_new_user.save
    
    redirect_to("/users/" + a_new_user.username)
  end
  
  def update
    the_user = params.fetch("query_username")
    input_username = params.fetch("username")
    matching_users = User.where({ :username => the_user})
    user = matching_users.at(0)
    
    user.username = input_username
    user.save
    redirect_to("/users/" + user.username)
  end

end
