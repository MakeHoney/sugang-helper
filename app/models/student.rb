class Student < ApplicationRecord
  establish_connection(:remote_db)
end
