class Subject < ApplicationRecord
  establish_connection(:remote_db)
end
