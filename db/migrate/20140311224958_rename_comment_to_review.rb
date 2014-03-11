class RenameCommentToReview < ActiveRecord::Migration
  def change
    rename_table :comments, :reviews

    Activity.where(content_type: "Comment").update_all("content_type = 'Review'")
  end
end
