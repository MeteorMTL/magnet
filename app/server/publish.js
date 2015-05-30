Meteor.publish('Votes', function () {
  return Votes.find();
});

Meteor.publish('Topics', function () {
  return Topics.find();
});

Meteor.publish('Topic', function (topicId) {
  console.log("topicId: ", topicId)
  return Topics.find({_id: topicId});
});

Meteor.publish('Photos', function () {
  return Photos.find();
});

Meteor.publish("UserData", function () {
  return Meteor.users.find({}, {fields: {
    'profile.name': 1,
    'emails': 1,
    'lastAnnounced': 1,
    'profile.facebook': 1,
    'profile.twitter': 1,
    'profile.linkedin': 1}});
});

Meteor.publish('Teams', function () {
  return Teams.find();
});

Meteor.publish('Commitments', function () {
  return Commitments.find();
});

Meteor.publish('Reactions', function () {
  return Reactions.find();
});

Meteor.publish(null, function () {
  return Meteor.roles.find({});
});
