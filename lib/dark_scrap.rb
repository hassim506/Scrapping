# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'nokogiri'

def scrap_coin_market_cap
  url = URI.parse('https://coinmarketcap.com/all/views/all/')
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  response = http.get(url.request_uri)
  doc = Nokogiri::HTML(response.body)

  scrape_crypto_prices(doc)
end

# Méthode pour extraire les cours des cryptomonnaies à partir du document HTML
def scrape_crypto_prices(doc)
  crypto_prices = [] # Initialisation d'un tableau pour stocker les cours des cryptomonnaies

  # Récupération des éléments HTML représentant les lignes de données des cryptomonnaies
  crypto_elements = doc.css('.cmc-table-row')
  crypto_elements.each do |crypto_element|
    # Extraction du nom et du prix de chaque cryptomonnaie
    name = extract_crypto_name(crypto_element)
    price = extract_crypto_price(crypto_element)

    # Ajout du nom et du prix dans un hash et ajout de ce hash au tableau crypto_prices
    crypto_prices << { name => price } unless name.empty? || price.zero?
  end

  # Retourne le tableau contenant les cours des cryptomonnaies
  crypto_prices
end

# Méthode pour extraire le nom d'une cryptomonnaie à partir d'un élément HTML
def extract_crypto_name(element)
  element.css('.cmc-table__column-name').text
end

# Méthode pour extraire le prix d'une cryptomonnaie à partir d'un élément HTML
def extract_crypto_price(element)
  element.css('.cmc-table__cell--sort-by__price').text.gsub(',', '').to_f
end

# Appel de la fonction pour récupérer les cours des cryptomonnaies
crypto_prices = scrap_coin_market_cap

# Affichage du tableau de hachages contenant les cours des cryptomonnaies
puts crypto_prices.inspect
