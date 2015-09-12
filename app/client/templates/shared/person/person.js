/*****************************************************************************/
/* Person: Event Handlers */
/*****************************************************************************/
Template.Person.events({
});

/*****************************************************************************/
/* Person: Helpers */
/*****************************************************************************/
Template.Person.helpers({
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
  },
  reactions: function () {
    var user = Meteor.users.findOne({_id: this._id});
    //return Reactions.find({$or: [{userId: user._id}, {evaluator: user._id}]});
    return Reactions.find({userId: user._id});
  }
});
/*****************************************************************************/
/* Person: Lifecycle Hooks */
/*****************************************************************************/
Template.Person.created = function () {
};

Template.Person.rendered = function () {
};

Template.Person.destroyed = function () {
};
