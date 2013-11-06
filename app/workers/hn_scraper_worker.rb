class HnScraperWorker

  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(min)
    Hn.scrape_hn
  end

end
