(->
  request = require("request")
  railway = {}

  scanResponseCode = (responseCode, callback) ->
    if responseCode is 200
      callback null
    else if responseCode is 401
      callback "Error: Authentication error. Either your API key was invalid or you passed a wrong hash."
    else
      callback "Error: Quota exhausted for day"
    return

  # railway._apikey = '16113';

  railway.setApikey = (_apikey) ->
  	@_apikey = _apikey
    
 railway.checkPnr = (pnrno, callback) ->
  request "http://api.railwayapi.com/pnr_status/pnr/#{pnrno}/apikey/#{@_apikey}", (err, res) ->
    unless err
      response = JSON.parse res.body
      scanResponseCode response.response_code, (resMsg) ->
        callback resMsg, response
        return
    else
      callback err, null
  return
      
  railway.stationCode = (stationName, callback) ->
    request "http://api.railwayapi.com/name_to_code/station/#{stationName}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, res.body
      else
        callback err, null
      return
    return

  railway.stationName = (stationCode, callback) ->
    request "http://api.railwayapi.com/code_to_name/code/#{stationCode}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, res.body
      else
        callback err, null
      return
    return

  railway.liveTrainStatus = (trainNo, callback) ->
  	request "http://api.railwayapi.com/live/train/#{trainNo}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, response
          return
      else
        callback err, null
    return

  railway.trainRoute = (trainNo, callback) ->
  	request "http://api.railwayapi.com/route/train/#{trainNo}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, response
          return
      else
        callback err, null
    return

  railway.trainBetweenStations = (source, destination, callback) ->
    request "http://api.railwayapi.com/between/source/#{source}/dest/#{destination}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, response
          return
      else
        callback err, null
    return

  railway.name_number = (train, callback) ->
  	request "http://api.railwayapi.com/name_number/train/#{train}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        scanResponseCode response.response_code, (resMsg) ->
          callback resMsg, response
          return
      else
        callback err, null
    return
    
  railway.seatAvailability = (trainNo, source, destination, date, type, checkQuota..., callback) ->
    callback 'Error: Invalide Date format. Please use DD-MM-YYYY', null if validateDay(date) is false
    if checkQuota.length is 0
      quota = 'GN'
    else quota = checkQuota[0]
    request "http://api.railwayapi.com/check_seat/train/#{trainNo}/source/#{source}/dest/#{destination}/date/#{date}/class/#{type}/quota/#{quota}/apikey/#{@_apikey}", (err, res) ->
      unless err
        response = JSON.parse res.body
        if response.err is false
          scanResponseCode response.response_code, (resMsg) ->
            callback resMsg, response
            return
        else
          callback 'Error: Unable to fetch seats right now. Please try again later.', null
      else
        callback err, null
    return

  module.exports = railway
  return
)()
