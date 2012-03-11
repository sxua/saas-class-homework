class MoviesController < ApplicationController

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
    session[:params] ||= {}
    
    if params[:sort_by].blank? && params[:ratings].blank?
      redirect_to movies_path(session[:params]) if session[:params][:sort_by].present? || session[:params][:ratings].present?
    else
      session[:params][:sort_by] = params[:sort_by] if params[:sort_by].present?
      session[:params][:ratings] = params[:ratings] if params[:ratings].present?
      redirect_to movies_path(session[:params]) if session[:params][:sort_by] != params[:sort_by] || session[:params][:ratings] != params[:ratings]
    end
    
    order = ['title', 'release_date'].include?(params[:sort_by]) ? "#{params[:sort_by]} ASC" : nil
    @ratings = params[:ratings] ? params[:ratings].keys : []
    movies = Movie.scoped({})
    movies = movies.where("rating IN(?)", @ratings) unless @ratings.empty?
    movies = movies.order(order) unless order.nil?
    @movies = movies.all
    @all_ratings = Movie.ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
