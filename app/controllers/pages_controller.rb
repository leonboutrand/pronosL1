require 'open-uri'

class PagesController < ApplicationController
  def home
    @users = User.all
    @scores = scraper(26).join("\n")
  end

  private

  def scraper(journee)
    url = "https://www.lfp.fr/ligue1/calendrier_resultat?sai=102&jour=#{journee}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    results = []
    doc.search('.stats a').each do |score|
      if score.text.strip != ''
        results << score.text.strip
      elsif score.attributes['href'].value =~ /feuille/
        results << scrap_inside(score.attributes['href'].value)
      end
    end
    p results
  end

  def scrap_inside(path)
    url = "https://www.lfp.fr/#{path}"
    inside = Nokogiri::HTML(open(url).read)
    inside.search('.buts').map { |x| x.text.strip }.join(' - ')
  end
end
