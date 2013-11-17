class V1::HnController < V1::BaseController
  include ActionView::Helpers::DateHelper

  def index
    # Return an error unless we've got the right API key.
    if params[:api_key] == "2659a3fd-2f13-40ed-86ca-b7a40692979c"
      scraper = Hn.new
      @hn = scraper.front_page
      render :json => {
        :updated => scraper.last_updated,
        :updated_words => time_ago_in_words(Time.at(scraper.last_updated)),
        :submissions => V1::HnPresenter.new(@hn)
      }
    else
      render :json => error_json(1, "Invalid API Key"), :status => 422
    end
  end

  def error
    render :json => error_json(0, "Invalid Request"), :status => 422
  end

  def error_json(code, message)
    {
      :error => {
        code: code,
        message: message
      }
    }
  end

  def show

  end

end
