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

  it '重複したキーは上書きされる' do
    @lru.put('a', 'dataA')
    @lru.put('b', 'dataB')
    @lru.put('b', 'dataBB')
    @lru.get('a').should == 'dataA'
    @lru.get('b').should == 'dataBB'
  end

  it 'キャッシュサイズをあとから減らせる' do
    lru = LRUCache.new(5)
    lru.put('a', 'dataA')
    lru.put('b', 'dataB')
    lru.put('c', 'dataC')
    lru.put('d', 'dataD')
    lru.put('e', 'dataE')
    lru.cache_size_change(3)
    lru.get('e').should == 'dataE'
    lru.get('d').should == 'dataD'
    lru.get('c').should == 'dataC'
    lru.get('b').should be_nil
    lru.get('a').should be_nil
  end

  it 'キャッシュサイズをあとから増やせる' do
    puts_test_data(2).each {|pair| @lru.put(pair[0], pair[1])}
    @lru.cache_size_change(5)
    @lru.max.should == 5
    puts_test_data(3, 'c').each {|pair| @lru.put(pair[0], pair[1])}
    
    @lru.get('c').should == 'dataC'
    @lru.get('d').should == 'dataD'
    @lru.get('e').should == 'dataE'
    @lru.get('b').should == 'dataB'
    @lru.get('a').should == 'dataA'
  end
end

def puts_test_data(num, start='a')
  box = []
  num.times do |n|
    box << [start, "data#{start.upcase}"]
    start = start.succ
  end
  box
end

describe 'test helper' do
  it 'テストデータ作成' do
    puts_test_data(2).should == [['a', 'dataA'], ['b', 'dataB']]
  end
end
