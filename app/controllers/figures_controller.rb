class FiguresController < ApplicationController
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles= Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end
  
  post '/figures' do
    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.create(:name => params[:figure][:name])
    if !@title[:name].empty?
      t = Title.create(:name => @title[:name])
      @figure.titles << t
    end
    if @title_ids
      @title_ids.each do |id|
        t = Title.find(id)
        @figure.titles << t
      end
    end
    if !@landmark[:name].empty?
      l = Landmark.create(:name => @landmark[:name])
      @figure.landmarks << l
    end
    if @landmark_ids
      @landmark_ids.each do |id|
        l = Landmark.find(id)
        @figure.landmarks << l
      end
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by(id: params[:id])
    # @title = @figure.title
    @titles= Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end
  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])

    @figure.name = params[:figure][:name]

    if !params[:figure][:title_ids].nil?
      
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find_by(id: title_id)
      end
    end

    if !params[:title][:name].strip.empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params[:landmark][:name].strip.empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  get "/figures/:id" do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end

end
