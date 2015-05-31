Meteor.startup(function () {
  var users = Meteor.users.find({emails: {$elemMatch: {address: {$in: ["davidrowley01@gmail.com", "paulcu@gmail.com", "tzumby@gmail.com", "ogourment@smarterportal.com", "calincu@gmail.com"]}}}});
  users.forEach(function (user) {
    Roles.addUsersToRoles(user._id, ['organizer']);
  });
  var charts = Charts.findOne({});
  if (!charts) {
    Charts.insert({name: "lead", description: "Leadership", instructions: "Has the leader lead well?"});
    Charts.insert({name: "heal", description: "Health", instructions: "Did anyone burn out? How to avoid?"});
    Charts.insert({name: "tech", description: "Technical", instructions: "Did they apply and improve their skills by working with you in this project?"});
  }
});
