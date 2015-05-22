/**
 * Meteor.publish('items', function (param1, param2) {
 *  this.ready();
 * });
 */


Meteor.publish('Votes', function (/* args */) {
  return Votes.find();
});

Meteor.publish('Topics', function (/* args */) {
  return Topics.find();
});

Meteor.publish('Photos', function (/* args */) {
  return Photos.find();
});

Meteor.publish("userData", function () {
  return Meteor.users.find({}, {fields: {'emails': 1, 'lastAnnounced': 1}});
});
