class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    input_address = params.fetch("query_address")
    input_name = params.fetch("query_name")
    input_neighborhood = params.fetch("query_neighborhood")
    
    
    a_new_venue = Venue.new
    a_new_venue.address = input_address
    a_new_venue.name = input_name
    a_new_venue.neighborhood = input_neighborhood

    a_new_venue.save

    redirect_to("/venues/#{a_new_venue.id}")
  end
  
  def update
    new_address = params.fetch("updated_address")
    new_name = params.fetch("updated_name")
    new_neighborhood = params.fetch("updated_neighborhood")
    
    the_id = params.fetch("venue_id")

    matching_venues = Venue.where({ :id => the_id })
    
    edited_venue = matching_venues.at(0)

    edited_venue.address = new_address 
    edited_venue.name = new_name
    edited_venue.neighborhood = new_neighborhood

    edited_venue.save
    
    redirect_to("/venues/" + the_id)
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

  def comment
    input_venue_id = params.fetch("comment_venue_id")
    input_author_id = params.fetch("comment_author_id")
    input_comment = params.fetch("comment_body")
    
    
    a_new_comment = Comment.new
    a_new_comment.author_id = input_author_id 
    a_new_comment.venue_id = input_venue_id
    a_new_comment.body = input_comment
   
    a_new_comment.save
    
    redirect_to("/venues/#{a_new_comment.venue_id}")
  end
end
