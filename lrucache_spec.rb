require 'lrucache'

describe LRUCache do
  before do
    @lru = LRUCache.new(2)
  end 

  it 'キーに対応する価を取得できる' do
    @lru.put('a', 'dataA')
    @lru.get('a').should == 'dataA'
    @lru.put('b', 'dataB')
    @lru.get('b').should == 'dataB'
  end 

  it '最大サイズが設定できる' do
    @lru.max.should == 2
  end 

  it '一つも使われていない場合は最初に追加したものから消える' do
    @lru.put('a', 'dataA')
    @lru.put('b', 'dataB')
    @lru.put('c', 'dataC')
    @lru.get('a').should be_nil
  end 

  it 'getされたら使われたとみなす' do
    @lru.put('a', 'dataA')
    @lru.put('b', 'dataB')
    @lru.get('a').should == 'dataA'
    @lru.put('c', 'dataC')
    @lru.get('b').should be_nil
  end
end
