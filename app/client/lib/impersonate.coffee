@Impersonate =
  _user: null
  _token: null
  _active: new ReactiveVar(false)

Impersonate.do = (toUser, cb) ->
  params = toUser: toUser
  if Impersonate._user
    params.fromUser = Impersonate._user
    params.token = Impersonate._token
  Meteor.call 'impersonate', params, (err, res) ->
    if err
      console.log 'Could not impersonate.', err
    unless err
      unless Impersonate._user
        Impersonate._user = res.fromUser
        # First impersonation
        Impersonate._token = res.token
      Impersonate._active.set true
      Meteor.connection.setUserId res.toUser
    if cb and cb.constructor and cb.apply
      cb.apply this, [
        err
        res.toUser
      ]
    return
  return

Impersonate.undo = (cb) ->
  Impersonate.do Impersonate._user, (err, res) ->
    unless err
      Impersonate._active.set false
    if cb and cb.constructor and cb.apply
      cb.apply this, [
        err
        res.toUser
      ]
    return
  return

# Reset data on logout
Meteor.autorun ->
  if Meteor.userId()
    return
  Impersonate._active.set false
  Impersonate._user = null
  Impersonate._token = null
  return

Template.registerHelper 'isImpersonating', ->
  Impersonate._active.get()
