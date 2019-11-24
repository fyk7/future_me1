CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_public = false
    config.fog_directory = 'future-me-s3'
    config.fog_credentials = {
      provider: 'AWS',
      region: Rails.application.credentials.aws[:region],     
      aws_access_key_id: Rails.application.credentials.aws[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:aws_secret_access_key], 
      path_style: true
    }
  end
end