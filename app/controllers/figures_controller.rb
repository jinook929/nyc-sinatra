class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    params[:figure][:title_ids] ||= []
    params[:figure][:landmark_ids] ||= []
    figure = Figure.create(params[:figure])
    figure.titles.push(Title.create(params[:title])) if !params[:title][:name].empty?
    figure.landmarks.push(Landmark.create(params[:landmark])) if !params[:landmark][:name].empty?

    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    params[:figure][:title_ids] ||= []
    params[:figure][:landmark_ids] ||= []
    figure = Figure.update(params[:id], params[:figure])
    figure.titles.push(Title.create(params[:title])) if !params[:title][:name].empty?
    figure.landmarks.push(Landmark.create(params[:landmark])) if !params[:landmark][:name].empty?
    redirect "/figures/#{params[:id]}"
  end
end
