require 'json'
require 'enumerator'
require 'faraday'

module MapGather
  class Collector
    attr_accessor :url

    def initialize(url = nil)
      raise ArgumentError, 'You must provide a valid URL' unless url.is_a? String

      @url = url
    end

    def oids
      @oids ||= get_oids
    end

    def features(&block)
      @features ||= get_features(&block)
    end

    private

    def get_oids
      results = get({
        where: 'OBJECTID IS NOT NULL',
        returnIdsOnly: true,
        f: 'pjson'
      })

      JSON.parse(results)['objectIds']
    end

    def get_features(&block)
      features = []

      oids.each_slice(100) do |ids|
        set = get_feature_set(ids)

        yield(set) if block_given?
        features.push(set)
      end

      features.flatten
    end

    def get_feature_set(ids)
      results = get({
        outFields: '*',
        returnGeometry: false,
        where: "OBJECTID IN (#{ids.join(',')})",
        f: 'pjson'
      })

      JSON.parse(results)['features']
    end

    def get(params)
      response = Faraday.get(@url, params)

      response.body
    end
  end
end
