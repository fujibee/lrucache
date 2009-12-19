class LRUCache
  attr_reader :max

  def initialize(max)
    @max = max 
    @cache = []
  end 

  def put(key, value)
    @cache << [key, value]
    wipeout
  end 

  def get(key)
    reorder(key)
    value = @cache.assoc(key)
    value.nil? ? nil : value.last
  end 

  private

  def reorder(key)
    value = @cache.assoc(key)
    @cache.delete(value)
    @cache << value
  end

  def wipeout
    @cache.shift if max < @cache.size
  end
end
