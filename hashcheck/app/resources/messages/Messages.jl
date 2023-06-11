module Messages

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Message

@kwdef mutable struct Message <: AbstractModel
  id::DbId = DbId()
  Rid::Int = 0
  Sid::Int = 0
  msg::String = ""
end

end
