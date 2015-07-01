Meteor.startup(function () {

  bootstrapUsers();

  var charts = Charts.findOne({});
  if (!charts) {
    Charts.insert({name: "stront-points", description: "Strong Points", instructions: "Has the leader led well?"});
    Charts.insert({name: "consider-improving", description: "Consider Improving", instructions: "Did anyone burn out? How to avoid?"});
  }

  bootstrapTeams();
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

  console.log('bootstrapUsers', Meteor.users.find().count());
}

function bootstrapTeams() {

  var user = Meteor.users.findOne();

  var message = Messages.findOne({});
  if (!message) {

    var team = Teams.findOne({});
    if (!team) {
      teamId = Teams.insert({
        name: "Team One",
        purpose: "We all belong to Team One",
        created: new Date(),
        createdBy: user._id});
      team = Teams.findOne({_id: teamId});
    }

    Messages.insert({
      teamId: team._id,
      userId: user._id,
      dateCreated: new Date(),
      message: "Coucou"
    });
    Messages.insert({
      teamId: team._id,
      userId: user._id,
      dateCreated: new Date(),
      message: "Wow, I think this is great. I can feel how much I'm going to enjoy playing this! What about you, @John?"
    });
  }

  console.log('bootstrapTeams teams:%d messages:%d',
    Teams.find().count(), Messages.find().count());
}
