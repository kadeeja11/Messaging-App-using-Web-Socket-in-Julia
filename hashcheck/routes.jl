using Genie, Genie.Router, Genie.Assets, JSON
Genie.config.websockets_server = true
Genie.config.webchannels_default_route = "chat"

Genie.WebChannels.broadcast("chat", "hey, this is from the server")

using Messages
using Users

struct details
  rid::Int
  MSG::String
  sid::Int
end


route("/") do
  Assets.channels_support()
end

d = Dict()

channel("chat/join") do
  a = params()[:WS_CLIENT]
  h = hash(a)
  s = string(h)
  id = params(:payload)["id"]
  save(User(hash=s, uid=id))
  d[s] = a
  return s
end

channel("chat/message") do
  a = params()[:WS_CLIENT]
  h = hash(a)
  s = string(h)
  print("success")
  key = s
  Rid = params(:payload)["Rid"]
  Sid = params(:payload)["Sid"]
  msg = params(:payload)["msg"]
  value = find(User, uid=Sid, hash=key)

  if isempty(value)
    return "The user doesnt exist"
  else
    deets = details(Rid, msg, Sid)
    json_data = JSON.json(deets)
    receiver_hash = find(User, uid=Rid)[1].hash
    Genie.WebChannels.message(d[receiver_hash], json_data)
  end
end