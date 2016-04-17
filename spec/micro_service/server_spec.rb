require 'spec_helper'

describe MicroService::Server do
	it 'has a version number' do
		expect(MicroService::Server::VERSION).not_to be nil
	end

	describe '#create' do
		before(:each) do
			@client_id = 1
			@url = "http://server.local"
		end
		it "should work" do
			@micro_service_server = MicroService::Server.new({
				client_id: @client,
				url: @url,
				secret: @secret,
			})

			expect(@micro_service_server.save).to eq(true)
		end
	end
end
