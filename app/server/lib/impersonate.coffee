Impersonate =
  admin: "admin"

# Reset all tokens
Meteor.startup ->
  selector = _impersonateToken:
    $exists: true
  modifier = $unset:
    _impersonateToken: ""
  options = multi: true
  Meteor.users.update selector, modifier, options

Meteor.methods
  impersonate: (params) ->
    currentUser = @userId
    check currentUser, String
    check params, Object
    check params.toUser, String
    if params.fromUser or params.token
      check params.fromUser, String
      check params.token, String
    throw new Meteor.Error(404, "User not found. Can't impersonate it.") unless Meteor.users.findOne(_id: params.toUser)
    roleAllow = false
    # if there is any role, use that
    if Impersonate.admin
      roleAllow = Roles.userHasRole(currentUser, Impersonate.admin)
    throw new Meteor.Error(403, "Permission denied. You need to be an admin to impersonate users.") if not params.token and not roleAllow
    if params.token
      # Impersonating with a token
      selector =
        _id: params.fromUser
        "services.impersonate.token": params.token
      isValid = Meteor.users.findOne(selector)
      throw new Meteor.Error(403, "Permission denied. Can't impersonate with this token.") unless isValid
    else
      # Impersonating with no token
      user = Meteor.users.findOne(_id: currentUser) or {}
      params.token = Meteor._get(user, "services", "resume", "loginTokens", 0, "hashedToken")
      selector = _id: currentUser
      modifier = $set:
        'services.impersonate.token': params.token
      Meteor.users.update(selector, modifier);
    @setUserId params.toUser
    fromUser: currentUser
    toUser: params.toUser
    token: params.token
