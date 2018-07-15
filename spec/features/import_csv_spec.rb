require 'rails_helper'

describe 'Products', type: :feature do
  stub_authorization!

  before { visit spree.admin_products_path }

  context 'as admin user' do
    it 'can find import csv form' do
      expect(page).to have_selector('form input[type="file"]', visible: true)
    end
    it 'cannot import without adding file', js: true do
      click_button('Import From Csv')

      expect(page).to have_content('Please choose file')
    end
    it 'can upload csv file', js: true do
      find('input#form_csv_file').click
      attach_file('form_csv_file', 'spec/support/test.csv' )
      find('input#form_csv_button').click

      expect(page).to have_content('File was imported sucessfully')
    end
  end
end
