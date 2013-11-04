desc "This is the Scrape HN worker"
task :scrape_hn => :environment do
    puts "Updating hn api..."
    # call this with $ rake scrape_hn

    [1,3,5,7,9].each do |min|
        HnScraperWorker.perform_in(min.minutes.from_now, min)
    end

    puts "done." 
end