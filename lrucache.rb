class LRUCache
  attr_reader :max

  def initialize(max)
    @max = max 
    @cache = []
  end 

  def put(key, value)
    tmp = @cache.assoc(key)
    if tmp
      @cache.delete(tmp)
      tmp[1] = value
      @cache << tmp
    else
      @cache << [key, value]
    end
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
