class GeneratingActivities < ActiveRecord::Migration
  def change
    contents = (Comment.all + Rating.all).sort_by(&:updated_at).reverse
    contents.each do |content|
      Activity.create(user_id: content.user_id, content: content)
    end
  end
end
