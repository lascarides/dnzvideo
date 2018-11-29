API_KEY = 'iaStyqKuqiBjgS7J6Td5'

require 'rubygems'
require 'json'
require 'csv'
require 'net/http'
require 'digest/sha1'

content_partners = {}

def facets(content_partner = nil)
	url = ""
	if content_partner.nil?
		url = "https://api.digitalnz.org/v3/records.json?api_key=#{API_KEY}&facets=content_partner&per_page=0&facets_per_page=500"
	else
		url = "https://api.digitalnz.org/v3/records.json?api_key=#{API_KEY}&facets=year,usage,collection,category&per_page=0&facets_per_page=500&and[content_partner][]=#{URI.escape(content_partner)}"
	end
	response = Net::HTTP.get_response(URI.parse(url)).body.force_encoding("UTF-8")
	result = JSON.parse(response)
	return [result['search']['facets'], result['search']['result_count']]
end

def get_record(id)
	url = "https://api.digitalnz.org/v3/records/#{id}.json?api_key=#{API_KEY}"
	response = Net::HTTP.get_response(URI.parse(url)).body.force_encoding("UTF-8")
	result = JSON.parse(response)
	result['record']
end

CSV.foreach("content-partners.csv", :headers => true) do |row|
	cp = row['Content partner']
	puts cp
	cp_facets, count = facets(cp)
	content_partners[cp] = {
		site: row['Site'],
		total: count,
		collections: cp_facets['collection'],
		usage: cp_facets['usage'],
		year: cp_facets['year'],
		formats: cp_facets['category'],
		type: row['Type'],
		country: row['Country']
	}
end

# Write content partners csv
CSV.open("output/content-partners.csv", "w", {:col_sep => "\t"}) do |csv|
	content_partners.each do |cp, info|
  		csv << [cp, info[:type], info[:country], info[:total], info[:year].keys.min, info[:year].keys.max]
  	end
end

# Write collections csv
CSV.open("output/collections-by-cp.csv", "w", {:col_sep => "\t"}) do |csv|
	content_partners.each do |cp, info|
		info[:collections].each do |coll, count|
	  		csv << [cp, coll, count]
		end
  	end
end

# Write years csv
CSV.open("output/years-by-cp.csv", "w", {:col_sep => "\t"}) do |csv|
	content_partners.each do |cp, info|
		info[:year].each do |year, count|
			if year.to_i > 1500 and year.to_i < 2018
		  		csv << [cp, year, count]
		  	end
		end
  	end
end

# Write formats csv
CSV.open("output/formats-by-cp.csv", "w", {:col_sep => "\t"}) do |csv|
	content_partners.each do |cp, info|
		info[:formats].each do |fmt, count|
	  		csv << [cp, fmt, count]
		end
  	end
end

# Write usages csv
CSV.open("output/usage-by-cp.csv", "w", {:col_sep => "\t"}) do |csv|
	content_partners.each do |cp, info|
		info[:usage].each do |usage, count|
	  		csv << [cp, usage, count]
		end
  	end
end


