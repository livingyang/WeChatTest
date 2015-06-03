Meteor.startup ->
  console.log 'startup'

WebApp.connectHandlers.use '/hello', (req, res, next) ->
  console.log 'hello'
  res.writeHead 200
  res.end "hello from: #{Meteor.release}"

WX_TOKEN = 'livingwxtest'
WX_DEVELOPER = 'gh_1e71365b146b'

WebApp.connectHandlers.use '/wxtest', (req, res, next) ->
  if req.method is 'GET'
    res.writeHead 200
    res.end if req.query.signature is getWxSignature WX_TOKEN, req.query.timestamp, req.query.nonce then req.query.echostr else ''

  else if req.method is 'POST'
    req.on 'data', (chunk) ->

      xml2js.parseString chunk.toString(), (err, result) ->
        result.xml.ToUserName = result.xml.FromUserName
        result.xml.FromUserName = WX_DEVELOPER

        builder = new xml2js.Builder cdata: true

        result.xml.CreateTime = Date.now()
        result.xml.Content[0] += "\n: from living"

        res.writeHead 200
        res.end builder.buildObject result


getWxSignature = (token, timestamp, nonce) ->
  shasum = (Npm.require 'crypto').createHash 'sha1'
  shasum.update [token, timestamp, nonce].sort().join('')
  shasum.digest 'hex'
