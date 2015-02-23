Photos = new Mongo.Collection("photos");

if (Meteor.isClient) {
  Meteor.subscribe("userData");
  // counter starts at 0
  Session.setDefault("counter", 0);
  Template.me.helpers({
    email: function () {
      email = "You need to log in or register";
      if (Meteor.user()) {
        email = Meteor.user().emails[0].address
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
    }
  });

  Template.people.helpers({
    people: function () {
      return Meteor.users.find({}, {sort: {lastAnnounced: -1}, limit: 100})
    }
  });

  Template.person.helpers({
    photo: function () {
      userPhoto = Photos.findOne({userId: this._id});
      return userPhoto.data;
    },
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
      Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.name": name, "profile.interests": interests, "profile.needs": needs, "lastAnnounced": new Date()}})
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
