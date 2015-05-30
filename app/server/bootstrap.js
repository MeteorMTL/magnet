Meteor.startup(function () {
  var users = Meteor.users.find({emails: {$elemMatch: {address: {$in: ["davidrowley01@gmail.com", "paulcu@gmail.com", "tzumby@gmail.com", "tzumby@gmail.com", "calincu@gmail.com"]}}}});
  users.forEach(function (user){
    Roles.addUsersToRoles(user._id, ['organizer']);
  });
});
