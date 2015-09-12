# Profile: Event Handlers
Template.Profile.events
  "click #photo_camera": ->
    cameraOptions =
      width: 800
      height: 600

    MeteorCamera.getPicture cameraOptions, (error, data) ->
      Session.set "photo", data
      userPhoto = Photos.findOne(userId: Meteor.userId())
      if userPhoto
        Photos.update
          _id: userPhoto._id
        ,
          $set:
            data: data
      else
        Photos.insert
          userId: Meteor.userId()
          data: data

  "submit #profile": (event, template) ->
    event.preventDefault()
    name = event.target.name
    linkedin = event.target.linkedin
    twitter = event.target.twitter
    facebook = event.target.facebook
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set:
        "profile.name": name.value
        "profile.linkedin": linkedin.value
        "profile.twitter": twitter.value
        "profile.facebook": facebook.value
        lastAnnounced: new Date()

# Me: Helpers
Template.Profile.helpers
  email: ->
    email = "You need to log in or register"
    email = Meteor.user().emails[0].address  if Meteor.user()
    email
  photo: ->
    userPhoto = Photos.findOne(userId: Meteor.userId())
    (if userPhoto then userPhoto.data else "")
  profile: ->
    user = Meteor.user()
    user.profile

# Me: Lifecycle Hooks
Template.Profile.created = ->

Template.Profile.rendered = ->

Template.Profile.destroyed = ->
