require 'csv'

module MapGather
  class Csv
    def initialize(features, output_file = 'output.csv')
      @csv = CSV.open(output_file, "w")

      generate
    end

    private

    def generate
      features.each_with_index do |feature|
        @csv << feature.keys if i == 0
        @csv << feature.values
      end
    end
  end
end
