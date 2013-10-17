class BackgroundSystem
  Dir[Rails.root.join('app', 'workers', '*.rb')].each  { |file| require file }
  @@async = true

  class << self
    include Rails.application.routes.url_helpers

    def sync!
      @@async = false
    end

    def async!
      @@async = true
    end

    def enqueue(worker, *args)
      if @@async
        worker.perform_async(*args)
      else
        worker.new.perform(*args)
      end
    end

    %w(in at).each do |suffix|
      define_method "enqueue_#{suffix}" do |worker_class, value, *args|

        if @@async
          worker_class.send("perform_#{suffix}", value, *args)
        else
          worker_class.new.perform(*args)
        end
      end
    end
  end
end
