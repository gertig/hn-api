class HnScraperWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options :retry => false

  recurrence { 
  							hourly.minute_of_hour(0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
  																	32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58) 
							}

  def perform(last_occurrence, current_occurrence)
  	# puts "Last Scraped: #{last_occurrence}"
  	# puts "Current Scraping: #{current_occurrence}"

    Hn.scrape_hn
  end

end

# Send a message to be processed asynchronously:
# HardWorker.perform_async('bob', 5)

# You can also send messages by calling the delay method on a class method:
# User.delay.do_some_stuff(current_user.id, 20)

# Sidekiq allows you to schedule the time when a job will be executed. You use perform_in(interval, *args) or perform_at(timestamp, *args) rather than the standard perform_async(*args):

# MyWorker.perform_in(3.hours, 'mike', 1)
# MyWorker.perform_at(3.hours.from_now, 'mike', 1)