/*****************************************************************************/
/* Me: Event Handlers */
/*****************************************************************************/
Template.Me.events({
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

/*****************************************************************************/
/* Me: Helpers */
/*****************************************************************************/
Template.Me.helpers({
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

/*****************************************************************************/
/* Me: Lifecycle Hooks */
/*****************************************************************************/
Template.Me.created = function () {
};

Template.Me.rendered = function () {
};

Template.Me.destroyed = function () {
};
