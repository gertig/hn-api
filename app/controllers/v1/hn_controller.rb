class V1::HnController < V1::BaseController

  def index
    scraper = Hn.new
    @hn = scraper.front_page
    render :json => {:submissions => V1::HnPresenter.new(@hn) }
  end

  def show

  end

end
