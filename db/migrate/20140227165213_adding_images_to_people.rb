class AddingImagesToPeople < ActiveRecord::Migration
  def change
    Person.pluck(:id).each do |id|
      ImageGenerator.perform_async("Person", id)
    end
  end
end
