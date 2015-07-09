Meteor.startup(function () {

  bootstrapUsers();

  var charts = Charts.findOne({});
  if (!charts) {
    Charts.insert({name: "stront-points", description: "Strong Points", instructions: "Has the leader led well?"});
    Charts.insert({name: "consider-improving", description: "Consider Improving", instructions: "Did anyone burn out? How to avoid?"});
  }
});

function bootstrapUsers() {

  var users = Meteor.users.find({emails: {$elemMatch: {address: {$in: ["davidrowley01@gmail.com", "paulcu@gmail.com", "yannick@bcimontreal.org", "ari.ramdial@gmail.com", "yasir.siddiqui@gmail.com", "ogourment@smarterportal.com"]}}}});

  if (!Roles._collection.findOne({"name": "organizer"})) {
    organizerRole = new Roles.Role('organizer');
  }
  if (!Roles._collection.findOne({"name": "participant"})) {
    participantRole = new Roles.Role('participant');
  }

  users.forEach(function (user) {
    if (!Roles.userHasRole(user._id, 'organizer')) {
      Roles.addUserToRoles(user._id, ['organizer']);
    }
    if (!Roles.userHasRole(user._id, 'admin')) {
      Roles.addUserToRoles(user._id, ['admin']);
    }
  });
  //console.log('bootstrapUsers', Meteor.users.find().count());
}
