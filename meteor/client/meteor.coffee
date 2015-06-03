Session.setDefault "counter", 0
Template.hello.helpers counter: ->
  Session.get "counter"

Template.hello.events "click button": ->

  # increment the counter when button is clicked
  Session.set "counter", Session.get("counter") + 1

  xmlString = '<xml><ToUserName><![CDATA[gh_1e71365b146b]]></ToUserName>
    <FromUserName><![CDATA[oHBxys-7HShHEMMW2IBnk0dG6xRE]]></FromUserName>
    <CreateTime>1433320302</CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[rr]]></Content>
    <MsgId>6156063821993217314</MsgId></xml>'

  HTTP.post 'http://localhost:3000/wxtest', content: xmlString, (error, result) ->
    console.log result
