Photos = new Mongo.Collection("photos");

Topics = new Mongo.Collection("topics");

Votes = new Mongo.Collection("votes");

if (Meteor.isClient) {

  Meteor.subscribe("userData");

  Template.topics.helpers({
    canVote: function () {
      return Meteor.user() && Topics.find().count();
    },
    topics: function() {
      return Topics.find({}, {sort: {totalPoints: -1}});
    },
    availablePoints: getAvailablePoints
  });

  Template.topics.events({
    "submit form": function(event, template) {
      event.preventDefault();
      var input = event.target.name;
      Topics.insert({name: input.value, totalPoints: 0});
      input.value = '';
    }
  });

  Template.topic.helpers({
    canUpvote: function () {
      return getAvailablePoints();
    },
    canDownvote: function () {
      var topic = this;
      var user = Meteor.user();
      if (user) {
        return Votes.findOne({userId: user._id, topicId: topic._id});
      }
    },
    topicSize: function () {
      var topic = this;
      if (topic.totalPoints <= 1) {
        return "xs-topic"
      } else if (topic.totalPoints < 4) {
        return "sm-topic"
      } else if (topic.totalPoints < 10) {
        return "md-topic"
      } else if (topic.totalPoints < 20) {
        return "lg-topic"
      } else if (topic.totalPoints < 30) {
        return "xl-topic"
      }
    }
  });

  Template.topic.events({
    "click .plusOne": function(event, template) {
      var topic = template.data;
      var user = Meteor.user();
      if (user) {
        var vote = Votes.findOne({
          userId: user._id,
          topicId: topic._id
        });
        if (vote) {
          Votes.update({_id: vote._id}, {$inc: {points: 1}});
        }
        else {
          Votes.insert({userId: user._id, topicId: topic._id, points: 1});
        }
        Topics.update({_id: topic._id}, {$inc: {totalPoints: 1}});
      }
    },
    "click .minusOne": function(event, template) {
      var topic = template.data;
      var user = Meteor.user();
      if (user) {
        var vote = Votes.findOne({
          userId: user._id,
          topicId: topic._id
        });
        if (vote) {
          if (vote.points == 1) {
            Votes.remove({_id: vote._id});
          }
          else {
            Votes.update({_id: vote._id}, {$inc: {points: -1}});
          }
        }
        Topics.update({_id: topic._id}, {$inc: {totalPoints: -1}});
      }
    }
  });

  Template.people.helpers({
    people: function () {
      return Meteor.users.find({}, {sort: {lastAnnounced: -1}, limit: 100});
    }
  });

  Template.person.helpers({
    photo: function () {
      userPhoto = Photos.findOne({userId: this._id});
      if (userPhoto) return userPhoto.data;
    },
    profile: function () {
      user = Meteor.users.findOne({_id: this._id});
      if (user && user.profile) {
        user.profile.email = user.emails ? user.emails[0].address : "";
      }
      return user.profile;
    }
  });

  Template.me.helpers({
    email: function () {
      email = "You need to log in or register";
      if (Meteor.user()) {
        email = Meteor.user().emails[0].address;
      }
      return email;
    },
    photo: function () {
      userPhoto = Photos.findOne({userId: Meteor.userId()});
      return userPhoto ? userPhoto.data : "";
    },
    profile: function () {
      user = Meteor.user();
      return user.profile;
    },
    topics: function () {
      var user = Meteor.user();
      if (user) {
        var topicIds = _.pluck(Votes.find({ userId: user._id }).fetch(), 'topicId');
        return Topics.find({ _id: {$in: topicIds}});
      }
    }
  });

  Template.me.events({
    'click button': function () {
      var cameraOptions = {
        width: 800,
        height: 600
      };

      MeteorCamera.getPicture(cameraOptions, function (error, data) {
        Session.set("photo", data);
        userPhoto = Photos.findOne({userId: Meteor.userId()});
        if (userPhoto) {
          Photos.update({_id: userPhoto._id}, {$set: {data: data}});
        } else {
          Photos.insert({
            userId: Meteor.userId(),
            data: data
          });
        }
      });
    },
    "submit form": function (event, template) {
      event.preventDefault();
      var name = event.target.name.value;
      Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.name": name, "lastAnnounced": new Date()}});
    }
  });
}

function getAvailablePoints() {

  var user = Meteor.user();
  if (user) {
    var usedPoints;
    var votes = Votes.find({userId: user._id}).fetch();
    if (!votes.length) usedPoints = 0;
    else {
      usedPoints = _.reduce(_.map(
        votes,
        function (vote) {
          return vote.points;
        }),
        function (sum, points) {
          return sum + points;
        });
    }
    return 20 - usedPoints;
  }
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });

  Meteor.users.allow({
    insert: function () {
      return true;
    },
    update: function () {
      return true;
    },
    remove: function () {
      return true;
    }
  });

  Meteor.publish("userData", function () {
    return Meteor.users.find({}, {fields: {'emails': 1, 'lastAnnounced': 1}});
  });
}
