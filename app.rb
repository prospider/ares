require 'sinatra'
require 'data_mapper'
require File.dirname(__FILE__) + './models.rb'
require 'json'
require 'Date'

before do
	content_type 'application/json'
end

get '/' do
	content_type 'html'
	erb :index
end

get '/repairs' do
	@repairs = Repair.all
	@repairs.to_json
end

post '/repairs/new' do
	@repair = Repair.new
	@repair.waiting_on_tech = false
	@repair.technician = params[:technician]
	@repair.sro = params[:sro]
	@repair.updated_at = DateTime.now
end

put '/repairs/:id' do
	@repair = Repair.find(params[:id])
	@repair.waiting_on_tech = params[:repair_on_tech]
	@repair.updated_at = DateTime.now
	if @repair.save then
		{:repair => @repair, :success => true}.to_json
	else
		{:repair => @repair, :success => false}.to_json
	end
end

delete '/repairs/:id' do
	@repair = Repair.find(params[:id])
	if @repair.destroy then
		{:repair => @repair, :success => true}.to_json
	else
		{:repair => @repair, :success => false}.to_json
	end
end