class WhoisData
  attr_reader :ip_address, :whois_client

  def initialize(args)
    @ip_address = args.fetch(:ip_address)
    @whois_client = Whois::Client.new
  end

  def get_whois_data
    whois_data = Hash.new
    data = whois_client.lookup(@ip_address)
    parsed = data.parser.record.to_s.gsub('%','').split("\n")
    parsed.each do |v|
        next unless v.include?(':')
        split_data = v.split(':')
        whois_data[split_data[0].downcase] = split_data[1].gsub(/^\s+/, '')
    end
    whois_data
  end
end



