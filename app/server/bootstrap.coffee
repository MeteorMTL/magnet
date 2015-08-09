bootstrapUsers = ->
  users = Meteor.users.find(emails:
    $elemMatch:
      address:
        $in: [ "davidrowley01@gmail.com", "paulcu@gmail.com", "yannick@bcimontreal.org", "ari.ramdial@gmail.com", "yasir.siddiqui@gmail.com", "ogourment@smarterportal.com" ]
  )
  organizerRole = new Roles.Role("organizer")  unless Roles._collection.findOne(name: "organizer")
  participantRole = new Roles.Role("participant")  unless Roles._collection.findOne(name: "participant")
  users.forEach (user) ->
    Roles.addUserToRoles user._id, [ "organizer" ]  unless Roles.userHasRole(user._id, "organizer")
    Roles.addUserToRoles user._id, [ "admin" ]  unless Roles.userHasRole(user._id, "admin")

Meteor.startup ->
  bootstrapUsers()
  charts = Charts.findOne({})
  unless charts
    Charts.insert
      name: "stront-points"
      description: "Strong Points"
      instructions: "Has the leader led well?"

    Charts.insert
      name: "consider-improving"
      description: "Consider Improving"
      instructions: "Did anyone burn out? How to avoid?"



#console.log('bootstrapUsers', Meteor.users.find().count());
