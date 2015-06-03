Meteor.startup ->
  console.log 'startup'

WebApp.connectHandlers.use '/hello', (req, res, next) ->
  console.log 'hello'
  res.writeHead 200
  res.end "hello from: #{Meteor.release}"

WX_TOKEN = 'livingwxtest'

WebApp.connectHandlers.use '/wxtest', (req, res, next) ->
  # console.log req.query
  # console.log [WX_TOKEN, req.query.timestamp, req.query.nonce].sort().join('')
  if req.method is 'GET'
    # shasum = (Npm.require 'crypto').createHash 'sha1'
    # shasum.update [WX_TOKEN, req.query.timestamp, req.query.nonce].sort().join('')
    #
    # # console.log shasum.digest 'hex'
    #
    # console.log req.method
    #
    res.writeHead 200
    res.end if req.query.signature is getWxSignature WX_TOKEN, req.query.timestamp, req.query.nonce then req.query.echostr else ''

  else if req.method is 'POST'
    console.log req.body

getWxSignature = (token, timestamp, nonce) ->
  shasum = (Npm.require 'crypto').createHash 'sha1'
  shasum.update [token, timestamp, nonce].sort().join('')
  shasum.digest 'hex'
