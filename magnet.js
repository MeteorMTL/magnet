Photos = new Mongo.Collection("photos");

if (Meteor.isClient) {
  Meteor.subscribe("userData");
  // counter starts at 0
  Session.setDefault("counter", 0);

  // used for templates: me and person 
  Template.registerHelper('photo', function(userId) {
    return Photos.findOne({userId: userId}) ? Photos.findOne({userId: userId}).data : "";
  });

  Template.me.helpers({
    email: function () {
      return Meteor.user() ? Meteor.user().emails[0].address : "You need to log in or register";
    },
    profile: function () {
      return Meteor.user().profile;
    }
  });

  Template.people.helpers({
    people: function () {
      return Meteor.users.find({}, {sort: {lastAnnounced: -1}, limit: 100})
    },
    beerDrinkers: function() {
      return "How many want to come out for a beer: " + Meteor.users.find({'profile.beer': {$regex: /.+/}}).count()
    }
  });

  Template.person.helpers({
    profile: function () {
      user = Meteor.users.findOne({_id: this._id});
      if (user && user.profile) {
        user.profile.email = user.emails ? user.emails[0].address : "";
      }
      return user.profile;
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
          Photos.update({_id: userPhoto._id}, {$set: {data: data}})
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
      var interests = event.target.interests.value;
      var needs = event.target.needs.value;
      var beer = event.target.beer.value;
      Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.name": name, "profile.interests": interests, "profile.beer": beer , "profile.needs": needs, "lastAnnounced": new Date()}})
    }
  })
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
