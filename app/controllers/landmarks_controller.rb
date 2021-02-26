class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'landmarks/new'
  end

  post '/landmarks' do
    params[:landmark][:figure_id] ||= nil
    if !params[:figure][:name].empty?
      figure = Figure.create(params[:figure])
      params[:landmark][:figure_id] = figure.id
    end
    landmark = Landmark.create(params[:landmark])
    redirect "/landmarks/#{landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    @figures = Figure.all
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    params[:landmark][:figure_id] ||= nil
    if !params[:figure][:name].empty?
      figure = Figure.create(params[:figure])
      params[:landmark][:figure_id] = figure.id
    end
    landmark = Landmark.update(params[:id], params[:landmark])
    redirect "/landmarks/#{landmark.id}"
  end
end
