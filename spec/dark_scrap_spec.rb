# frozen_string_literal: true

require_relative 'dark_scrap' #  chemin vers mon fichier de scraping

RSpec.describe 'Scrap CoinMarketCap' do
  it 'scrapes data from CoinMarketCap' do
    expect(scrap_coin_market_cap).not_to be_empty # Vérifie que les données scrapés ne sont pas vides
  end

  it 'returns data in the correct format' do
    crypto_prices = scrap_coin_market_cap
    expect(crypto_prices).to be_an(Array) # Vérifie que le résultat est un tableau
    expect(crypto_prices.length).to be > 1 # Vérifie qu'il y a plus d'une cryptomonnaie dans le tableau

    # Vérifie que les éléments du tableau sont des hachages avec un nom et un prix
    expect(crypto_prices.all? do |crypto|
             crypto.is_a?(Hash) && crypto.keys.first.is_a?(String) && crypto.values.first.is_a?(Float)
           end).to be_truthy
  end
end
