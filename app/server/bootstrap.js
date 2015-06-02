Meteor.startup(function () {
  var users = Meteor.users.find({emails: {$elemMatch: {address: {$in: ["davidrowley01@gmail.com", "paulcu@gmail.com", "tzumby@gmail.com", "ogourment@smarterportal.com", "calincu@gmail.com"]}}}});
  users.forEach(function (user) {
    Roles.addUsersToRoles(user._id, ['organizer']);
  });
  var charts = Charts.findOne({});
  if (!charts) {
    Charts.insert({name: "stront-points", description: "Strong Points", instructions: "Has the leader led well?"});
    Charts.insert({name: "consider-improving", description: "Consider Improving", instructions: "Did anyone burn out? How to avoid?"});
  }
});
