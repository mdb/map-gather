require 'spec_helper'

describe MapGather::Collector do
  let(:collector) { described_class }
  let(:collector_inst) { described_class.new('http://gis.phila.gov/arcgis/rest/services/PhilaGov/Golf_Courses/MapServer/0/query') }

  describe '#new' do
    context 'when it is not passed a url parameter' do
      it 'raises an an ArgumentError' do
        expect { collector.new }.to raise_error(ArgumentError)
      end
    end

    context 'when it is passed a url parameter' do
      it 'sets a url instance var' do
        expect(collector_inst.url).to eq 'http://gis.phila.gov/arcgis/rest/services/PhilaGov/Golf_Courses/MapServer/0/query'
      end
    end
  end

  describe '#oids' do
    it 'returns an array of object ids' do
      expect(collector_inst.oids).to eq (1..12).to_a
    end
  end

  describe '#features' do
    let(:features) { collector_inst.features }

    it 'returns an array' do
      expect(features).to be_a Array
    end

    context 'a features array item' do
      let(:feature) { features[0] }

      it 'has an "attributes" key' do
        expect(feature['attributes']).to be_a Hash
      end
    end
  end
end
