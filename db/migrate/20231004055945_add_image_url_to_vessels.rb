class AddImageUrlToVessels < ActiveRecord::Migration[7.1]
  def change
    add_column :vessels, :image_url, :text, default: ''
  end
end
