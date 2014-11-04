DataMapper.setup(:default, 'sqlite://db/database.sqlite')

class Repair
  include DataMapper::Resource

  property :id, Serial
  property :sro, String
  property :waiting_on_tech, Boolean
  property :technician, String
  property :updated_at,	DateTime

end

DataMapper.auto_upgrade!