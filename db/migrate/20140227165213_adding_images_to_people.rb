class AddingImagesToPeople < ActiveRecord::Migration
  def change
    Person.all.each do |person|
      MovieFeeder.send(:generate_images, person)
    end
  end
end
