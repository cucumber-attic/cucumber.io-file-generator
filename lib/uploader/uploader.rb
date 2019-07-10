# frozen_string_literal: true

require 'aws-sdk-s3'

# Uploader uploads all files found in the static directory
class Uploader
  def initialize(s3_client = Aws::S3::Client.new(region: 'eu-west-1'), bucket = 'cucumber-io-generated-files')
    @bucket = bucket
    @s3 = s3_client
  end

  def upload(location = './static')
    files = Dir.glob(location + '/**/*.*')

    success = 0
    files.each do |file|
      key = s3_key(file)
      puts "uploading #{file} to #{key}"
      s3_upload(key, file)
      success += 1
    end

    "upload complete. found: #{files.length} uploaded: #{success}"
  end

  private

  def s3_key(filepath)
    path = File.dirname(filepath).split('/')
    "#{path[-1]}/#{File.basename(filepath)}"
  end

  def s3_upload(key, file)
    @s3.put_object(
      body: file,
      key: key,
      bucket: @bucket
    )
  end
end
