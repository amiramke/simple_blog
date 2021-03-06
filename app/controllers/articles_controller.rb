class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  before_filter :load_article#, :load_articles
  around_filter :catch_exceptions

  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article  = Article.includes(:comments).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article# = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        # format.html {render :show, notice: 'Article was successfully created.'}
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    #@article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    #@article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

private

  def load_articles
    @articles = Article.all.each { |article| article.title.upcase! }
  end

  def load_article
    @article = Article.find(params[:id]) if params[:id]
  end

  def catch_exceptions
#    #started = Time.now
#    #yield
#    #elapsed = Time.now - started
#    #logger.info("#{action_name} took #{elapsed} seconds (ami's note)")
#    flash[:notice] = "gogogogog"
    begin
      yield
      logger.info("I'm here")
      logger.info(params[:action])
    rescue Exception => e
      flash[:notice] = "Caught exception! #{e} for action #{params[:action]}"
        unless  params[:action] == 'index'
          redirect_to :action => 'index'
        else
          render :text => "xyz"
        end
    end
  end

end
