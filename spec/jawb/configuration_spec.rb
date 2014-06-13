describe 'configuration' do

  let(:keys) { Jawb::Configuration::VALID_CONFIG_KEYS }
  let(:key) { keys.sample }

  after { Jawb.reset }

  it 'sets config keys' do
    Jawb.configure do |config|
      config.public_send("#{key}=", key)
      expect(Jawb.public_send(key)).to eq key
    end
  end

  describe '#authorization' do
    it 'should return nil' do
      expect(Jawb.authorization).to be_nil
    end
  end

  describe '#environment' do
    it 'should return nil' do
      expect(Jawb.environment).to be_nil
    end
  end

  describe '#format' do
    it 'should return default format' do
      expect(Jawb.format).to eq Jawb::Configuration::DEFAULT_FORMAT
    end
  end

  describe '#user_agent' do
    it 'should return default user agent' do
      expect(Jawb.user_agent).to eq Jawb::Configuration::DEFAULT_USER_AGENT
    end
  end


end
