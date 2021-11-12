module CacheRefreshable
  extend ActiveSupport::Concern

  included do
    after_save :delete_cache
    after_destroy :delete_cache
  end

  def delete_cache
    Rails.cache.delete(cache_key)
  end

  def cache_key
    raise NotImplementedError.new "Need to be implemented in the model"
  end

end