require 'open-uri'
require 'nokogiri'

def scrap_coin_market_cap
  # URL du site CoinMarketCap
  url = 'https://coinmarketcap.com/all/views/all/'

  # dey tidji l'URL and parse th html with Nokogiri
  html = URI.open(url)
  doc = Nokogiri::HTML(html)

  # Initialize array for stocked the cours of cryptommonaies
  crypto_prices = []

  # dafay recuperer element you am prix akk tour cryptommonaies yepp
  crypto_elements = doc.css('.cmc-table-row')

  # Parcours chaque élémen pr extraire l nom et l prix d'la cryptomonnaie
  crypto_elements.each do |crypto_element|
    name = crypto_element.css('.cmc-table__column-name').text
    price = crypto_element.css('.cmc-table__cell--sort-by__price').text.gsub(',', '').to_f

  # Stocke le nom et le prix dans un hash puis ajoute ce hash o tableau # rubocop:disable Layout/CommentIndentation
    crypto_prices << { name => price } unless name.empty? || price.zero?
  end

  # Retourne le tableau contenant ls cours des cryptomonnaies
  crypto_prices
end

# Appel la function pour rcuprer ls cours ds cryptomonnaies
crypto_prices = scrap_coin_market_cap

# Affiche le tablo de hachages contenant ls cours ds cryptomonnaies
puts crypto_prices.inspect
