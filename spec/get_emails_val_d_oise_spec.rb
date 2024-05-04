# frozen_string_literal: true

require_relative 'get_emails_val_d_oise'

RSpec.describe do
  describe '#get_townhall_email' do
    it 'returns an email address' do
      email = get_townhall_email('http://annuaire-des-mairies.com/95/avernes.html')
      expect(email).to be_a(Hash)
      expect(email.values.first).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end
  end

  describe '#get_townhall_urls' do
    it 'returns an array of townhall URLs' do
      urls = get_townhall_urls
      expect(urls).to all(match(%r{^http://annuaire-des-mairies\.com/\d{2}/[\w-]+\.html$}))
    end
  end

  describe '#get_all_emails' do
    it 'returns a list of email addresses for all townhalls in Val d\'Oise' do
      emails = get_all_emails
      expect(emails).to all(be_a(Hash))
      expect(emails.map { |hash| hash.values.first }).to all(match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i))
    end
  end
end
