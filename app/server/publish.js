Meteor.publish('Votes', function () {
  return Votes.find();
});

Meteor.publish('Topics', function () {
  return Topics.find();
});

Meteor.publish('Topic', function (topicId) {
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

Meteor.publish('Messages', function (teamId) {
  return Messages.find({teamId: teamId});
});

Meteor.publish('TopicTeams', function (topicId) {
  var votes = Votes.find({topicId: topicId}).fetch();
  var userIds = _.pluck(votes, "userId");
  var commitments = Commitments.find({userId: {$in: userIds}}).fetch();
  var teamIds = _.pluck(commitments, "teamId");
  return Teams.find({_id: {$in: teamIds}});
});

Meteor.publish('Commitments', function () {
  return Commitments.find();
});

Meteor.publish('Reactions', function () {
  return Reactions.find();
});

Meteor.publish('Charts', function () {
  return Charts.find();
});
