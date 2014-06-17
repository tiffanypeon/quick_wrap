require 'spec_helper'
require './spec/fixtures/deal.rb'

describe QuickWrap::Client do
  let(:connection) { double(:http_connection) }
  let(:client) { QuickWrap::Client.new environment: 'test' }
  let(:config_keys) { QuickWrap::Configuration::VALID_CONFIG_KEYS }
  let(:create_url) { '/api/v1/promotions'}


  it 'inherits config' do
    expect(client).to respond_to(config_keys.sample)
  end

  before { Faraday.stub(:new) { connection } }

  describe '#post_methods' do
    it 'calls post correctly' do
      params = { foo: 'bar' }
      QuickWrap::SampleParams.stub(:sample_params) { params }
      expect(connection).to receive(:put).with(create_url)
      client.post_with_params(create_url, :sample_params)
    end
  end

  describe '#get_thing_with_id' do
    let(:promotion_id) { 123 }
    it 'calls Api correctly' do
      expect(connection).to receive(:get).with("/api/v1/promotions/#{promotion_id}")
      client.get_thing_with_id('api/v1/promotions', promotion_id)
    end
  end
end
