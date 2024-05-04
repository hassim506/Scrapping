# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# Méthode pour récupérer l'e-mail d'une mairie à partir de son URL
def townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url)) # rubocop:disable Security/Open
  { page.css('h1')[0].text => page.css('tbody tr:nth-child(4) td:nth-child(2)').text }
end

# Méthode pour récupérer les URLs de chaque mairie du Val d'Oise
def townhall_urls
  Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html')).css('a.lientxt').map { |link| "http://annuaire-des-mairies.com#{link['href']}" }
end

# Méthode pour obtenir les adresses e-mail de toutes les mairies du Val d'Oise
def all_emails
  townhall_urls.map { |url| get_townhall_email(url) }
end

# Affiche les adresses e-mail de toutes les mairies du Val d'Oise
puts all_emails
