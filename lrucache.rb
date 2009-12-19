class LRUCache
  attr_reader :max

  def initialize(a)
    @max = a 
    @cache = {}
  end 

  def put(a, b)
    @cache[a] = b 
  end 

  def get(a)
    @cache[a]
  end 

  def size
    @cache.size
  end 
end
