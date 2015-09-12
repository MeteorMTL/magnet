bootstrapUsers = ->
  users = Meteor.users.find(emails:
    $elemMatch:
      address:
        $in: [ "davidrowley01@gmail.com", "paulcu@gmail.com", "yannick@bcimontreal.org", "ari.ramdial@gmail.com", "yasir.siddiqui@gmail.com", "ogourment@smarterportal.com" ]
  )
  users.forEach (user) ->
    Roles.addUserToRoles user._id, ["organizer"] unless Roles.userHasRole(user._id, "organizer")
    Roles.addUserToRoles user._id, ["admin"] unless Roles.userHasRole(user._id, "admin")
  return Meteor.users.findOne(emails:
    $elemMatch:
      address: "paulcu@gmail.com"
  )

Meteor.startup ->
  admin = bootstrapUsers()
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
  playfield = Playfields.findOne({})
  playfieldsNames = ["Meteor", "UX", "Hardware", "Growth Hacking"]
  unless playfield
    _.each(playfieldsNames, (playfieldName) ->
      Playfields.insert
        name: playfieldName
        authorId: admin._id
    )




#console.log('bootstrapUsers', Meteor.users.find().count());
