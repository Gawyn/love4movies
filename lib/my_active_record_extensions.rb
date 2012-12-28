module MyActiveRecordExtensions
  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create(attributes)
      self.where(attributes).first || self.create(attributes)
    end
  end
end

ActiveRecord::Base.send(:include, MyActiveRecordExtensions)
