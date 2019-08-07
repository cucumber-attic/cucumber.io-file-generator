# frozen_string_literal: true

require 'aws-sdk-s3'
require 'pry-byebug'

# Uploader uploads all files found in the static directory to s3
class Uploader
  def initialize(s3_client = Aws::S3::Client.new(region: 'eu-west-1'), bucket = 'cucumber-io-generated-files')
    @bucket = bucket
    @s3_client = s3_client
  end

  def upload(location = './static')
    files = Dir.glob(location + '/**/*.*')

    binding.pry
    if files.empty?
      return "nothing to upload, skipping rest of process"
    end

    success = 0
    files.each do |file|
      key = s3_key(file)
      puts "uploading #{file} to #{key}" unless ENV['RSPEC'] == 'true'
      s3_upload(key, file)
      success += 1
    end

    "upload complete. found: #{files.length} uploaded: #{success}"
  end

  private

  def s3_key(filepath)
    path = File.dirname(filepath).split('/')
    path[-1] == 'sitemaps' ? File.basename(filepath) : "#{path[-1]}/#{File.basename(filepath)}"
  end

  def s3_upload(key, file)
    s3 = Aws::S3::Resource.new(client: @s3_client)
    obj = s3.bucket(@bucket).object(key)
    obj.upload_file(File.absolute_path(file))
  end
end
