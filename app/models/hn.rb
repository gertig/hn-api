class Hn

  require 'nokogiri'
  require 'open-uri'
  require 'json'
  require 'cgi'

  # Gets the info from Redis
  def front_page
    page = []
    i = 0
    while i < 30
      rank = i + 1
      key = "hn_link:" + rank.to_s
      if $redis.exists(key)
        # puts "The REDIS get for key:#{key} is #{$redis.get(key)}"
        page << JSON.parse($redis.get(key))
      end
      i += 1
    end
    page
  end


  def self.scrape(url)
    return Nokogiri::HTML(open(url).read) #using .read on the open call returns properly encoded UTF-8 for special characters like &eacute;
  end

  def self.is_too_short(str)
    return str.length <= 5
  end

  def self.scrape_hn
    titles = []
    links = []
    points = []
    submitters = []
    comments = []
    item_ids = []

    puts "SCRAAAAPE HN"
    @hn = scrape("https://news.ycombinator.com")

    # @hn.css("td .subtext span").each_with_index do |item, index|
    #   if item[:id].include? "score_"
    #     point_count = item.text.gsub("points", "").strip!
    #     points[index] = point_count
    #   end
    # end

    @hn.css("td .subtext").each_with_index do |item, index|

      rank = index + 1
      # puts "Rank: #{rank}"

      score = item.css("span").first
      if score
        if score[:id].include? "score_"
          point_count = score.text.gsub("points", "").strip!
          points[index] = point_count
          # puts "Points: #{point_count}"
        end

        submitter = item.css("a").first
        if submitter[:href].include? "user"
          submitter_handle = submitter.text #.strip!
          submitters[index] = submitter_handle
          # puts "Submitter: #{submitter_handle}"
        end

        comment = item.css("a").last
        if comment[:href].include? "item"
          comment_path  = comment[:href]
          comment_count = comment.text.gsub("comments", "").strip!
          comment_url   = "https://news.ycombinator.com/#{comment_path}"
          comments[index] = { url: comment_url, count: comment_count }
          # puts "Comment: #{comment_url}"

          params = CGI.parse(URI.parse(comment_url).query)
          # puts "THE ITEM ID (Stripped from a url)"
          # puts params["id"]
          item_ids[index] = params["id"][0]
        end
      else
        points[index] = "0"
        submitters[index] = "yc_advertisement"
        comments[index] = "yc_advertisement"
      end

      # puts "Index: #{index}, Item: #{item}"
    end # .css("td .subtext")

    puts "Scraped The Points, Submitters, and Comments"

    # puts "Get Title"
    @hn.css("td .title a").each_with_index do |item, index|
      title = item.text #unless is_too_short(item.text)
      link = item[:href] # unless is_too_short(item.text)
      # puts "Title: #{title}"
      # puts "Link: #{link}"

      titles[index] = title
      links[index] = link
    end

    # puts "Scraped **********************************"
    puts "Scraped #{links.count} Links"
    # puts "Scraped **********************************"

    i = 0
    while i < 30
      rank = i + 1
      key = "hn_link:" + rank.to_s
      $redis.set(key, {:id => item_ids[i], :rank => rank, :title => titles[i], :link => links[i],
                       :points => points[i], :submitter => submitters[i],
                       :comments => comments[i]
                      }.to_json)
      i += 1
    end

    # delay(:run_every => 1.minutes ).scrape_hn
    # delay(:run_at => 1.minutes.from_now.getutc ).scrape_hn

    return true
  end



end
