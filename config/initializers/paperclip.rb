Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_region] = ENV.fetch('AWS_REGION')
Paperclip::Attachment.default_options[:s3_credentials] = {
    access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
}
Paperclip::Attachment.default_options[:bucket] = ENV.fetch('S3_BUCKET_NAME')
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = ENV.fetch('AWS_HOST')

