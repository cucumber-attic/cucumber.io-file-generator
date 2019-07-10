# frozen_string_literal: true

require 'aws-sdk-s3'

require_relative '../../lib/uploader/uploader.rb'

describe Uploader do
  describe 'upload' do
    it 'uploads all files in the static directory' do
      expected = 'upload complete. found: 4 uploaded: 4'

      s3 = Aws::S3::Client.new(region: 'eu-west-1', stub_responses: true)
      s3.stub_responses(:put_object)

      u = Uploader.new(s3, 'test-bucket')
      actual = u.upload('./test_data/test_static')

      expect(actual).to eq expected
    end
  end
end
