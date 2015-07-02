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

Template.Message.events({
  'click .delete': function (event, template) {
    var messageId = template.find('li').id;
    // TODO method and check userId
    Messages.remove({_id: messageId});
  },
  'click .thumbs_up': function (event, template) {
    var teamId = Router.current().params._id;
    var messageId = template.find('li').id;
    Likes.insert({
      teamId: teamId,
      messageId: messageId,
      userId: Meteor.userId()
    });
  }
});

/*****************************************************************************/
/* TeamShow: Helpers */
/*****************************************************************************/
Template.TeamShow.helpers({
  messages: function () {
    var teamId = Router.current().params._id;
    return Messages.find({teamId: teamId}, {sort: {createdAt: 1}});
  }
});

Template.Message.helpers({
  photo: function () {
    userPhoto = Photos.findOne({userId: this.userId});
    if (userPhoto) return userPhoto.data;
  },
  css_class: function () {
    var message = this;
    var now = new Date();
    if (now - message.createdAt < 1000) return "popout";
    return "";
  },
  likes: function () {
    var message = this;
    var likes = Likes.find({messageId: message._id}).count();
    return (likes) ? likes : '';
  },
  canDelete: function () {
    var message = this;
    var userId = message.userId;
    return userId === Meteor.userId();
  },
  canLike: function () {
    var message = this;
    var userId = message.userId;
    var liked = Likes.findOne({
      messageId: message._id,
      userId: Meteor.userId()
      });
    return !liked;
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
