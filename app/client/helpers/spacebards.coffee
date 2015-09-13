Template.registerHelper "active", (path) ->
  (if Router.current().url is path then "active" else "")

Template.registerHelper "debug", (optionalValue) ->
  if typeof console isnt "undefined" or typeof console.log isnt "undefined"
    console.log "Current Context"
    console.log "===================="
    console.log this
    if optionalValue
      console.log "Value"
      console.log "===================="
      console.log optionalValue
    return ""
  alert this
  alert optionalValue  if optionalValue
  ""

Template.registerHelper "hasRole", (role) ->
  if Meteor.user()
    Roles.userHasRole(Meteor.user()._id, role)
  else
    ""

Template.registerHelper "userHasRole", (userId, role) ->
  user = Meteor.users.findOne(_id: userId)
  if user
    Roles.userHasRole(user._id, role)
  else
    ""
