class Major < ApplicationRecord
  establish_connection(:remote_db)
end
