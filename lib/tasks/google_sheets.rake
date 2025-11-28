# lib/tasks/google_sheets.rake
namespace :google_sheets do
  task import_products: :environment do
    GoogleSheetsImportService.new.import_products_from_sheet
  end
end