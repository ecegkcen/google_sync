# lib/app/services/google_sheets_import_service.rb
require "google/apis/sheets_v4"
require "googleauth"

class GoogleSheetsImportService
  SPREADSHEET_ID = "1M1ig7D5N4HJAqkUzKena-g94VB-CE78ZqzTOWLsJtec" # Google Sheet ID
  RANGE = "Sayfa1!A2:E" # Başlık satırını atlamak için A2’den başlıyoruz

  def import_products_from_sheet
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = "GoogleSyncApp"
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open("./config/celtic-acumen-479620-i6-6e8bf9a13bfa.json"),
      scope: [ "https://www.googleapis.com/auth/spreadsheets" ]
    )

    response = service.get_spreadsheet_values(SPREADSHEET_ID, RANGE)

    if response.values.nil? || response.values.empty?
      puts "⚠ Sheet'ten veri gelmedi veya range yanlış!"
      return
    end

    response.values.each do |row|
      Product.create(
        name: row[0],
        price: row[1].to_f,
        stock: row[2].to_i,
        category: row[3]
      )
      puts "✅ Ürün eklendi: #{row[0]}"
    end

    puts "🎉 Tüm ürünler import edildi!"
  end
end
