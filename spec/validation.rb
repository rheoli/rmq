describe 'validation' do
  before do
    @rmq = RubyMotionQuery::RMQ
  end

  it 'should return validation from RMQ or an instance of rmq' do
    @rmq.validation.should == RubyMotionQuery::Validation

    rmq = RubyMotionQuery::RMQ.new
    rmq.validation.should == RubyMotionQuery::Validation
  end

  describe 'plumbing methods' do
    it 'should match regex to boolean' do
      @rmq.validation.regex_match?('test', /test/).should == true
      @rmq.validation.regex_match?('test', /taco/).should == false
    end
  end

  describe 'valid?' do
    it 'can validate email' do
      @rmq.validation.valid?('test@test.com', :email).should == true
      @rmq.validation.valid?('test', :email).should == false
    end

    it 'can validate url' do
      @rmq.validation.valid?('https://www.infinitered.com', :url).should == true
      @rmq.validation.valid?('test', :url).should == false
    end

    it 'can validate dateiso' do
      @rmq.validation.valid?('2014-03-02', :dateiso).should == true
      @rmq.validation.valid?('test', :dateiso).should == false
    end

    it 'can validate number' do
      @rmq.validation.valid?('53.9', :number).should == true
      @rmq.validation.valid?(98.6, :number).should == true
      @rmq.validation.valid?('test', :number).should == false
    end

    it 'can validate digits' do
      @rmq.validation.valid?('45', :digits).should == true
      @rmq.validation.valid?(69, :digits).should == true
      @rmq.validation.valid?('test', :digits).should == false
      @rmq.validation.valid?(6.9, :digits).should == false
    end

    it 'can validate ipv4' do
      @rmq.validation.valid?('192.168.1.1', :ipv4).should == true
      @rmq.validation.valid?('192.168.1.', :ipv4).should == false
    end

    it 'can validate time' do
      @rmq.validation.valid?('10:23', :time).should == true
      @rmq.validation.valid?('test', :time).should == false
    end

    it 'can validate uszip' do
      @rmq.validation.valid?('70003', :uszip).should == true
      @rmq.validation.valid?('70003-8844', :uszip).should == true
      @rmq.validation.valid?('K1A 0B1', :uszip).should == false
    end

    it 'can validate usphone' do
      @rmq.validation.valid?('504 555 8989', :usphone).should == true
      @rmq.validation.valid?('555 8989', :usphone).should == true
      @rmq.validation.valid?('504.555.8989', :usphone).should == true
      @rmq.validation.valid?('504-555-8989', :usphone).should == true
      @rmq.validation.valid?('5045558989', :usphone).should == true
      @rmq.validation.valid?('504 555 8989 x1227', :usphone).should == false
      @rmq.validation.valid?('test', :usphone).should == false
    end

    it 'raises an RuntimeError for missing validation methods' do
      should.raise(RuntimeError) do
        @rmq.validation.valid?('test', :madeupthing)
      end
      should.not.raise(RuntimeError) do
        @rmq.validation.valid?('test', :email, :url)
        @rmq.validation.valid?('test@test.com', :email)
      end
    end

  end

end