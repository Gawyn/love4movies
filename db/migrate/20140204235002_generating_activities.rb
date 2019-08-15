class GeneratingActivities < ActiveRecord::Migration
  def change
    # The following migration is a data migration. It shouldn't have been here in the first place.
=begin
    contents = (Comment.all + Rating.all).sort_by(&:updated_at).reverse
    contents.each do |content|
      Activity.create(user_id: content.user_id, content: content)
    end
=end
  end
end
