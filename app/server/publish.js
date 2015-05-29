Meteor.publish('Votes', function (/* args */) {
  return Votes.find();
});

Meteor.publish('Topics', function (/* args */) {
  return Topics.find();
});

Meteor.publish('Topic', function (topicId) {
  console.log("topicId: ", topicId)
  return Topics.find({_id: topicId});
});

Meteor.publish('Photos', function (/* args */) {
  return Photos.find();
});

Meteor.publish("UserData", function () {
  return Meteor.users.find({}, {fields: {'profile.name': 1, 'emails': 1, 'lastAnnounced': 1}});
});

Meteor.publish('Teams', function (/* args */) {
  return Teams.find();
});

Meteor.publish('Commitments', function (/* args */) {
  return Commitments.find();
});
