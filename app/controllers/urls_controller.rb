class UrlsController < ApplicationController
  def new
    @shortened_url = Url.new
  end

  def create
    @shortened_url = Url.new(shortened_url_params)
    if @shortened_url.save
      flash[:shortened_id] = @shortened_url.id
      redirect_to new_url_url
    else
      render :action => "new"
    end
  end

  def show
    @shortened_url = Url.find(params[:id])

    u = URI.parse(@shortened_url.url)
    #check if link has a protocol
    #if not add http:// to it and redirect
    if (!u.scheme)
      u = u.to_s.prepend("http://")
    end

    redirect_to u.to_s

  end

  private
  	def shortened_url_params
  		params.require(:url).permit(:url)
  	end

end