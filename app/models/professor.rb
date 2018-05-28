class Professor < ApplicationRecord
  establish_connection(:remote_db)
end
