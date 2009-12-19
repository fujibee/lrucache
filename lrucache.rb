class LRUCache
  attr_reader :max

  def initialize(a)
    @max = a 
    @cache = {}
    @order = []
  end 

  def put(a, b)
    @cache[a] = b
    @order << a
    wipeout
  end 

  def get(a)
    reorder(a)
    @cache[a]
  end 

  def size
    @cache.size
  end 

  def index(a)
    @order.index(a)
  end

  private

  def reorder(a)
    @order.delete(a)
    @order << a
  end

  def wipeout
    @cache.delete(@order.first) if max < size
  end
end
