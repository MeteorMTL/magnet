# Person: Event Handlers
Template.Person.events
  'click [data-impersonate]': (e, data) ->
    userId = $(e.currentTarget).attr('data-impersonate')
    Impersonate.do userId
    return

# Person: Helpers
Template.Person.helpers
  photo: ->
    userPhoto = Photos.findOne(userId: @_id)
    userPhoto.data  if userPhoto
  profile: ->
    user = Meteor.users.findOne(_id: @_id)
    user.profile.email = (if user.emails then user.emails[0].address else "") if user and user.profile
    user.profile
