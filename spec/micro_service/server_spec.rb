require 'spec_helper'

describe MicroService::Server do
	it 'has a version number' do
		expect(MicroService::Server::VERSION).not_to be nil
	end
	before(:each) do
		@client_id = 1
		@url = "http://server.local"
		@secret = 123
	end

	describe "#install" do
		it "should work" do
			stub_request(:post, "http://server.local/install").
			with(:body => "{\"install_url\":\"http://self.local/install\",\"uninstall_url\":\"\"}",
				 :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
			to_return(:status => 200, :body => "", :headers => {})

			MicroService::Server.install("#{@url}/install", "http://self.local/install")
		end
	end

	describe "#signed_request" do
		it "should work" do
			stub_request(:post, "#{@url}/make/request/to/api/thats/authorized").
			with(:body => "{\"payload\":\"some data\"}").
			to_return(:status => 200, :body => "", :headers => {})

			micro_service_server = MicroService::Server.new({
				client_id: @client_id,
				url: @url,
				secret: @secret,
			})

			micro_service_server.signed_request(Net::HTTP::Post.new("/make/request/to/api/thats/authorized")) do |http, request|
				request.body = {
					"payload" => "some data"
				}.to_json
			end
		end
	end

	describe "#valid_authentication_header" do
		it "should work" do
			micro_service_server = MicroService::Server.new({
				client_id: @client_id,
				url: @url,
				secret: @secret,
			})

			authentication_header = micro_service_server.send(:valid_authentication_header)

			# Get the parts!
			parts = CGI::parse(authentication_header)

			expect(parts["algorithm"]).to eq(["HmacSHA256"])
			expect(parts["client_id"]).to eq(["1"])
			expect(parts["service_url"]).to eq(["http://server.local"])
			expect(parts["timestamp"].first.to_i).to be_within(10).of((Time.now.to_i)*1000) # Close enough
		end
	end

	describe '#create' do
		it "should work" do
			micro_service_server = MicroService::Server.new({
				client_id: @client_id,
				url: @url,
				secret: @secret,
			})

			expect(micro_service_server.save).to eq(true)
		end
	end
end
