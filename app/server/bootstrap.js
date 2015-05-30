Meteor.startup(function () {
  var users = Meteor.users.find({emails: {$elemMatch: {address: {$in: ["davidrowley01@gmail.com", "paulcu@gmail.com"]}}}});
  users.forEach(function (user){
    Roles.addUsersToRoles(user._id, ['organizer']);
  });
});
