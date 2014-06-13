describe 'configuration' do

  let(:keys) { QuickWrap::Configuration::VALID_CONFIG_KEYS }
  let(:key) { keys.sample }

  after { QuickWrap.reset }

  it 'sets config keys' do
    QuickWrap.configure do |config|
      config.public_send("#{key}=", key)
      expect(QuickWrap.public_send(key)).to eq key
    end
  end

  describe '#authorization' do
    it 'should return nil' do
      expect(QuickWrap.authorization).to be_nil
    end
  end

  describe '#environment' do
    it 'should return nil' do
      expect(QuickWrap.environment).to be_nil
    end
  end

  describe '#format' do
    it 'should return default format' do
      expect(QuickWrap.format).to eq QuickWrap::Configuration::DEFAULT_FORMAT
    end
  end

  describe '#user_agent' do
    it 'should return default user agent' do
      expect(QuickWrap.user_agent).to eq QuickWrap::Configuration::DEFAULT_USER_AGENT
    end
  end


end
