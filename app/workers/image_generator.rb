class ImageGenerator
  include Sidekiq::Worker
  
  def perform(object_class, id)
    MovieFeeder.generate_images(eval(object_class).find(id))
  end
end
