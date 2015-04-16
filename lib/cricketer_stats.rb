require "cricketer_stats/version"
require "mechanize"

module CricketerStats
  
  def self.get_random_cricketer_stats(num=1)
    page=mechanize.get("http://en.wikipedia.org/wiki/List_of_One_Day_International_cricketers")
    data=page.search('small').collect{|country| country.children.search('a')}.flatten.map{|z| {z["href"] => z.text}}.sample(num)
    arr = []
    data.each do |h|
      arr<<get_one(h)
    end
    arr
  end

  private

  def self.get_one(h)
    table=mechanize.get("http://en.wikipedia.org"+h.keys.first).at('table.infobox table')
    parsed_data = table.search('tr')
    {"title"=>h.values.first, "data"=>construct_data_hash(parsed_data)}
  end

  def self.construct_data_hash(parsed_data)
    keys=["Matches","Runs scored", "Wickets", "Catches", "Stumpings", "Batting average", "Bowling average"]
    types=parsed_data.shift.search('th').collect(&:text)[1..-1]
    h={}
    parsed_data.each do |p|
      h[p.search('th').text.delete("\n")]=p.search('td').collect(&:text)[types.index(types.find{|l| l.match(/ODI/) })]
    end
    h["Catches"],h["Stumpings"]=h["Catches/stumpings"].match(/(.*)\/(.*)/).captures
    h.select!{|k,v| keys.include? k}
  end

  def self.mechanize
    @mechanize ||= ::Mechanize.new
  end
end
