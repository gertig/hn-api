class HnScraperWorker

  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(min)
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