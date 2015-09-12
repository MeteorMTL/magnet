Template.Player.events

# Player: Helpers
Template.Player.helpers
  photoBackgroundStyle: ->
    userPhoto = Photos.findOne(userId: @_id)
    "background-image: url('" + userPhoto?.data + "')" if userPhoto
  profile: ->
    user = Meteor.users.findOne(_id: @_id)
    user.profile.email = (if user.emails then user.emails[0].address else "")  if user and user.profile
    user.profile
  editing: ->
    Session.get "target" + @_id + Template.parentData(1)._id
  creator: ->
    (if @_id is Template.parentData(1).authorId then "organizer" else "")

# Player: Lifecycle Hooks
Template.Player.created = ->

Template.Player.rendered = ->

Template.Player.destroyed = ->
