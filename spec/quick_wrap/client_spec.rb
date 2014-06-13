require 'spec_helper'
require './spec/fixtures/deal.rb'

describe QuickWrap::Client do
  let(:connection) { double(:http_connection) }
  let(:client) { QuickWrap::Client.new environment: 'test' }
  let(:config_keys) { QuickWrap::Configuration::VALID_CONFIG_KEYS }
  let(:create_url) { '/api/v1/promotions'}
  let(:deal) { Deal.new }


  it 'inherits config' do
    expect(client).to respond_to(config_keys.sample)
  end

  before { Faraday.stub(:new) { connection } }

  describe '#create_or_update' do
    context 'SmartCoupon' do
      it 'creates param structure' do
        connection.stub(:put)
        expect(QuickWrap::SmartCoupon).to receive(:promotion_params).with(deal).and_return({})
        client.create_or_update(:smart_coupon, deal)
      end

      it 'calls post correctly' do
        params = { foo: 'bar' }
        QuickWrap::SmartCoupon.stub(:promotion_params) { params }
        expect(connection).to receive(:put).with(create_url)
        client.create_or_update(:smart_coupon, deal)
      end
    end

    it 'raises on unsupported promotion type' do
      expect {
        client.create_or_update(:foo, deal)
      }.to raise_error QuickWrap::UnsupportedPromotionType
    end
  end

  describe '#get_promotion' do
    let(:promotion_id) { 123 }
    it 'calls BtlApi correctly' do
      expect(connection).to receive(:get).with("/api/v1/promotions/#{promotion_id}")
      client.get_promotion(promotion_id)
    end
  end
end
