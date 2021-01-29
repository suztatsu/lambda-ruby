require 'base64'
require 'json'
require 'stringio'
require 'zlib'

### This function is sample for following architecture.
### CloudWatch Logs (Subscription Filter) -> Kinesis Data Streams -> Lambda

def lambda_handler(event:, context:)
 for record in event['Records'] do
  payload = Base64.decode64(record["Data"])
  gz_data = Zlib::GzipReader.new(StringIO.new(payload.to_s))    
  json_subscription_filter_data = JSON.parse(gz_data.read)
  for log_event in json_subscription_filter_data["logEvents"] do 
   puts(log_event["message"])
  end
 end
end