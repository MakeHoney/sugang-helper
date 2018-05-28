class TakeSubject < ApplicationRecord
  establish_connection(:remote_db)
end
