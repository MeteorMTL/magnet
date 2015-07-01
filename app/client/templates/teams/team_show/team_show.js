/*****************************************************************************/
/* TeamShow: Event Handlers */
/*****************************************************************************/
Template.TeamShow.events({
  "submit form": function (event, template) {
    event.preventDefault();
    var input = event.target.message;
    var teamId = Router.current().params._id;
    var message = {
      teamId: teamId,
      userId: Meteor.userId(),
      message: input.value,
      createdAt: new Date()
    };
    Messages.insert(message);
    input.value = '';
  }
});

/*****************************************************************************/
/* TeamShow: Helpers */
/*****************************************************************************/
Template.TeamShow.helpers({
  messages: function () {
    var teamId = Router.current().params._id;
    return Messages.find({teamId: teamId}, {sort: {createdAt: 1}});
  },
  photo: function () {
    userPhoto = Photos.findOne({userId: this.userId});
    if (userPhoto) return userPhoto.data;
  },
  canDelete: function () {
    var message = this;
    var userId = message.userId;
    return userId === Meteor.userId();
  }
});

/*****************************************************************************/
/* TeamShow: Lifecycle Hooks */
/*****************************************************************************/
Template.TeamShow.created = function () {
};

Template.TeamShow.rendered = function () {
};

Template.TeamShow.destroyed = function () {
};
