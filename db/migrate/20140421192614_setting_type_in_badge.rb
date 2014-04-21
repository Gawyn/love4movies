class SettingTypeInBadge < ActiveRecord::Migration
  def change
    Badge.update_all(type: "GeneralBadge")
  end
end
